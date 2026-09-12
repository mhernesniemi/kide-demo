/**
 * Seed the Media Library with demo photos and attach three of them to the
 * seeded blog posts. Idempotent: uploads dedupe by content hash.
 *
 *   node --import tsx scripts/seed-demo-images.ts <dir-with-photo-N.jpg> [manifest.json]
 *
 * Runs against the local database/storage. For the deployed demo, the
 * manifest lists each uploaded file's storage path so the originals can be
 * pushed to remote R2 and the asset rows copied to remote D1.
 */
import { readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { createCmsContext } from "@kidecms/core/context";

const [dir, manifestPath] = process.argv.slice(2);
if (!dir) {
  console.error("Usage: seed-demo-images.ts <dir> [manifest.json]");
  process.exit(1);
}

// Photos from picsum.photos (Unsplash license). `post` attaches the image to that post.
const photos = [
  { file: "photo-1.jpg", alt: "Fjord seen from a rocky plateau under a blue sky", post: "announcing-the-acme-spring-release" },
  { file: "photo-2.jpg", alt: "Winding road through green highland hills", post: "five-habits-of-teams-that-ship-every-week" },
  { file: "photo-3.jpg", alt: "Snow-covered base camp tent below Himalayan peaks", post: "how-northwind-cut-onboarding-time-in-half" },
  { file: "photo-4.jpg", alt: "Granite cliffs and pine forest reflected in a calm river" },
  { file: "photo-5.jpg", alt: "Sea stacks off a rugged coastline" },
  { file: "photo-6.jpg", alt: "Clouds mirrored on a flooded salt flat" },
  { file: "photo-7.jpg", alt: "Orange jellyfish drifting in deep blue water" },
  { file: "photo-8.jpg", alt: "Close-up portrait of a lioness" },
];

const { cms, assets, dispose } = await createCmsContext();
const ctx = { _system: true, _skipSearch: true };
const posts = (await (cms as any).posts.find({ status: "any", limit: 100 })) as Array<{ _id: string; slug: string }>;
const manifest: Array<{ file: string; storagePath: string; mimeType: string }> = [];

for (const photo of photos) {
  const bytes = await readFile(path.join(dir, photo.file));
  const file = new File([bytes], photo.file, { type: "image/jpeg" });
  const asset = await assets.upload(file, { alt: photo.alt, dedupe: true });
  manifest.push({ file: photo.file, storagePath: asset.storagePath, mimeType: asset.mimeType });
  console.log(`  ${photo.file} → ${asset.url} (${asset.width}×${asset.height})`);

  if (photo.post) {
    const post = posts.find((p) => p.slug === photo.post);
    if (!post) {
      console.warn(`  ! no post with slug "${photo.post}" — skipped attach`);
      continue;
    }
    // update() on a published document leaves the change as a pending draft
    // (readers keep seeing the _published snapshot), so publish it too.
    await (cms as any).posts.update(post._id, { image: asset.url }, ctx);
    await (cms as any).posts.publish(post._id, ctx);
    console.log(`    attached to post "${photo.post}" and published`);
  }
}

if (manifestPath) await writeFile(manifestPath, JSON.stringify(manifest, null, 2));
await dispose();
