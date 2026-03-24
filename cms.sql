PRAGMA foreign_keys=OFF;
CREATE TABLE IF NOT EXISTS "__drizzle_migrations" (
				id SERIAL PRIMARY KEY,
				hash text NOT NULL,
				created_at numeric
			);
INSERT INTO __drizzle_migrations VALUES(NULL,'b902531aef73e2be88496121b91c8b112a0bad71e9469643af660eb6544a583a',1774382553632);
CREATE TABLE `cms_asset_folders` (
	`_id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`parent` text,
	`_created_at` text NOT NULL
);
CREATE TABLE `cms_assets` (
	`_id` text PRIMARY KEY NOT NULL,
	`filename` text NOT NULL,
	`mime_type` text NOT NULL,
	`size` integer NOT NULL,
	`width` integer,
	`height` integer,
	`focal_x` real,
	`focal_y` real,
	`alt` text,
	`folder` text,
	`storage_path` text NOT NULL,
	`_created_at` text NOT NULL
);
CREATE TABLE `cms_authors` (
	`_id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`description` text,
	`slug` text,
	`title` text NOT NULL,
	`avatar` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
INSERT INTO cms_authors VALUES('author_maya','Maya Chen','Leads the editorial direction across product, design, and growth.','maya-chen','Editor in Chief',NULL,'2026-03-24T20:03:56.779Z','2026-03-24T20:03:56.779Z');
INSERT INTO cms_authors VALUES('author_leo','Leo Marshall','Full-stack engineer with a focus on developer experience and content infrastructure.','leo-marshall','Lead Developer',NULL,'2026-03-24T20:03:56.781Z','2026-03-24T20:03:56.781Z');
INSERT INTO cms_authors VALUES('author_anna','Anna Brooks','Brings clarity to complex interfaces through systems thinking and user research.','anna-brooks','Design Lead',NULL,'2026-03-24T20:03:56.782Z','2026-03-24T20:03:56.782Z');
INSERT INTO cms_authors VALUES('author_eero','James Webb','Infrastructure and deployment automation. Keeps things running smoothly.','james-webb','DevOps Engineer',NULL,'2026-03-24T20:03:56.782Z','2026-03-24T20:03:56.782Z');
CREATE TABLE `cms_authors_translations` (
	`_id` text PRIMARY KEY NOT NULL,
	`_entity_id` text NOT NULL,
	`_language_code` text NOT NULL,
	`description` text,
	FOREIGN KEY (`_entity_id`) REFERENCES `cms_authors`(`_id`) ON UPDATE no action ON DELETE cascade
);
CREATE TABLE `cms_front_page` (
	`_id` text PRIMARY KEY NOT NULL,
	`blocks` text,
	`_status` text DEFAULT 'draft' NOT NULL,
	`_published_at` text,
	`_publish_at` text,
	`_unpublish_at` text,
	`_published` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
INSERT INTO cms_front_page VALUES('L-_aqk4ig4Nacj8QSA0kL','[{"type":"hero","eyebrow":"Astro-native CMS","heading":"Your content, your code, one app","body":"Define collections in TypeScript. Get a full admin UI, typed API, and optimized delivery, all inside your Astro project.","ctaLabel":"Open admin","ctaHref":"/admin"},{"type":"text","heading":"How it works","content":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Define your collections in code. The generator produces Drizzle tables, TypeScript types, Zod validators, and a typed local API. The admin UI renders from your schema at runtime; add a field and it appears immediately."}]},{"type":"paragraph","children":[{"type":"text","value":"Your public pages query content through the typed local API. No HTTP overhead, no serialization, just plain function calls with full type safety."}]}]}},{"type":"faq","heading":"Common questions","items":[{"title":"Do I need a separate database server?","description":"No. Development uses SQLite with zero configuration. For Cloudflare deployment, it uses D1. No external databases to manage."},{"title":"Can I use this with an existing Astro project?","description":"Yes. The CMS lives in src/cms/ and does not interfere with your existing pages, components, or integrations."},{"title":"How does caching work?","description":"Content pages are server-rendered and cached using Astro''s route caching. When content changes, lifecycle hooks invalidate the relevant cache tags automatically."},{"title":"Is there vendor lock-in?","description":"No. The CMS runtime is editable project code, not an npm dependency. The database layer uses Drizzle ORM which works with any standard database."},{"title":"What deployment targets are supported?","description":"Node.js with SQLite for simple deployments, and Cloudflare Workers with D1 and R2 for edge deployment. The setup script handles the configuration."}]}]','published','2026-03-24T20:03:56.787Z',NULL,NULL,NULL,'2026-03-24T20:03:56.787Z','2026-03-24T20:03:56.787Z');
CREATE TABLE `cms_front_page_translations` (
	`_id` text PRIMARY KEY NOT NULL,
	`_entity_id` text NOT NULL,
	`_language_code` text NOT NULL,
	`blocks` text,
	FOREIGN KEY (`_entity_id`) REFERENCES `cms_front_page`(`_id`) ON UPDATE no action ON DELETE cascade
);
CREATE TABLE `cms_invites` (
	`_id` text PRIMARY KEY NOT NULL,
	`user_id` text NOT NULL,
	`token` text NOT NULL,
	`expires_at` text NOT NULL,
	`used_at` text
);
CREATE TABLE `cms_locks` (
	`_id` text PRIMARY KEY NOT NULL,
	`collection` text NOT NULL,
	`document_id` text NOT NULL,
	`user_id` text NOT NULL,
	`user_email` text NOT NULL,
	`locked_at` text NOT NULL
);
CREATE TABLE `cms_menus` (
	`_id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`slug` text,
	`items` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
INSERT INTO cms_menus VALUES('6wug_bRzkYWdzpcLIC7HJ','Main Navigation','main','[{"id":"m1","label":"Home","href":"/","children":[]},{"id":"m2","label":"Blog","href":"/blog","children":[{"id":"m5","label":"Getting Started","href":"/blog/getting-started-with-kide-cms","children":[]},{"id":"m6","label":"Deploying to Cloudflare","href":"/blog/deploying-to-cloudflare","children":[]},{"id":"m7","label":"Building Block Types","href":"/blog/building-custom-block-types","children":[]}]},{"id":"m3","label":"About","href":"/about","children":[]},{"id":"m4","label":"Features","href":"/features","children":[]}]','2026-03-24T20:03:56.786Z','2026-03-24T20:03:56.786Z');
INSERT INTO cms_menus VALUES('jbO_wfSmDT6XDQC23v9X_','Footer','footer','[{"id":"f1","label":"Home","href":"/","children":[]},{"id":"f2","label":"Blog","href":"/blog","children":[]},{"id":"f3","label":"About","href":"/about","children":[]},{"id":"f4","label":"GitHub","href":"https://github.com/mhernesniemi/kide-cms","target":"_blank","children":[]}]','2026-03-24T20:03:56.787Z','2026-03-24T20:03:56.787Z');
CREATE TABLE `cms_menus_translations` (
	`_id` text PRIMARY KEY NOT NULL,
	`_entity_id` text NOT NULL,
	`_language_code` text NOT NULL,
	`items` text,
	FOREIGN KEY (`_entity_id`) REFERENCES `cms_menus`(`_id`) ON UPDATE no action ON DELETE cascade
);
CREATE TABLE `cms_pages` (
	`_id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`slug` text,
	`summary` text,
	`image` text,
	`related_posts` text,
	`seo_description` text,
	`blocks` text,
	`_status` text DEFAULT 'draft' NOT NULL,
	`_published_at` text,
	`_publish_at` text,
	`_unpublish_at` text,
	`_published` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
INSERT INTO cms_pages VALUES('ayLJcxLQSIeI3_HJJh0YM','About','about','Learn more about Kide CMS and the ideas behind it.',NULL,NULL,NULL,'[{"type":"text","heading":"Built for developers who ship content sites","content":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Most CMS platforms are either too simple for real projects or too complex to understand. Kide aims for the middle ground: enough structure to handle content-heavy sites, simple enough that one developer can understand the entire system."}]},{"type":"paragraph","children":[{"type":"text","value":"Everything is code. The schema is TypeScript. The admin renders from that schema. The API is generated from it. There is one source of truth and it lives in your repository."}]}]}},{"type":"text","heading":"What makes Kide different","content":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS runs inside your Astro application: same process, same deployment. There is no separate API server to maintain, no external service to pay for, and no network hop between your CMS and your frontend."}]},{"type":"paragraph","children":[{"type":"text","value":"Your content schema is defined in TypeScript. From that single definition, the system generates database tables, TypeScript types, validation schemas, and a fully typed local API. Add a field to your config and it appears in the admin panel immediately."}]}]}},{"type":"faq","heading":"Frequently asked questions","items":[{"title":"Who is this for?","description":"Developers and small teams building content-driven websites who want full control over their CMS without maintaining a separate service."},{"title":"What makes this different from Payload or Strapi?","description":"Kide runs inside your Astro app: same process, same deployment. No separate API server, no external database to manage in development. Relations return IDs, not auto-populated documents, so queries are always predictable."},{"title":"Is it production-ready?","description":"The core features are solid: collections, fields, admin UI, drafts, versioning, i18n, access control, and caching. It is actively developed and used in real projects."},{"title":"Can I deploy anywhere?","description":"Yes. Kide supports both Node.js (with SQLite) and Cloudflare Workers (with D1 and R2). The setup script lets you choose your deployment target."}]}]','published','2026-03-24T20:03:56.787Z',NULL,NULL,NULL,'2026-03-24T20:03:56.787Z','2026-03-24T20:03:56.787Z');
INSERT INTO cms_pages VALUES('Jbd6OotCGag_ViGHIrD3q','Features','features','A closer look at what Kide CMS offers out of the box.',NULL,NULL,NULL,'[{"type":"text","heading":"Everything you need, nothing you don''t","content":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS ships with a complete feature set for building content-driven websites. Every feature is designed to work together seamlessly while staying simple enough to understand and customize."}]}]}},{"type":"faq","heading":"Core features","items":[{"title":"Collections and fields","description":"Define any content structure with 13 field types: text, slug, email, number, boolean, date, select, richText, image, relation, array, json, and blocks."},{"title":"Admin panel","description":"A full-featured admin UI that renders from your schema. Includes data tables with sorting and search, inline editing, keyboard shortcuts, and dark mode."},{"title":"Drafts and publishing","description":"Save drafts without affecting the public site. Schedule content to publish and unpublish at specific times. Discard changes to revert to the published version."},{"title":"Version history","description":"Every save creates a version. Restore any previous version with one click."},{"title":"Internationalization","description":"Per-field translation support. Mark fields as translatable and manage translations side-by-side in the admin UI."},{"title":"Asset management","description":"Upload, organize, and optimize images. Folder organization, focal point cropping, and automatic format conversion."},{"title":"Access control","description":"Role-based permissions per collection and per operation. Field-level access rules for fine-grained control."}]}]','published','2026-03-24T20:03:56.787Z',NULL,NULL,NULL,'2026-03-24T20:03:56.787Z','2026-03-24T20:03:56.787Z');
CREATE TABLE `cms_pages_translations` (
	`_id` text PRIMARY KEY NOT NULL,
	`_entity_id` text NOT NULL,
	`_language_code` text NOT NULL,
	`title` text NOT NULL,
	`slug` text,
	`summary` text,
	`seo_description` text,
	`blocks` text,
	FOREIGN KEY (`_entity_id`) REFERENCES `cms_pages`(`_id`) ON UPDATE no action ON DELETE cascade
);
CREATE TABLE `cms_pages_versions` (
	`_id` text PRIMARY KEY NOT NULL,
	`_doc_id` text NOT NULL,
	`_version` integer NOT NULL,
	`_snapshot` text NOT NULL,
	`_created_at` text NOT NULL,
	FOREIGN KEY (`_doc_id`) REFERENCES `cms_pages`(`_id`) ON UPDATE no action ON DELETE cascade
);
INSERT INTO cms_pages_versions VALUES('K8weTMdTyNRO4dl3yZ4YG','ayLJcxLQSIeI3_HJJh0YM',1,'{"title":"About","slug":"about","summary":"Learn more about Kide CMS and the ideas behind it.","blocks":[{"type":"text","heading":"Built for developers who ship content sites","content":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Most CMS platforms are either too simple for real projects or too complex to understand. Kide aims for the middle ground: enough structure to handle content-heavy sites, simple enough that one developer can understand the entire system."}]},{"type":"paragraph","children":[{"type":"text","value":"Everything is code. The schema is TypeScript. The admin renders from that schema. The API is generated from it. There is one source of truth and it lives in your repository."}]}]}},{"type":"text","heading":"What makes Kide different","content":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS runs inside your Astro application: same process, same deployment. There is no separate API server to maintain, no external service to pay for, and no network hop between your CMS and your frontend."}]},{"type":"paragraph","children":[{"type":"text","value":"Your content schema is defined in TypeScript. From that single definition, the system generates database tables, TypeScript types, validation schemas, and a fully typed local API. Add a field to your config and it appears in the admin panel immediately."}]}]}},{"type":"faq","heading":"Frequently asked questions","items":[{"title":"Who is this for?","description":"Developers and small teams building content-driven websites who want full control over their CMS without maintaining a separate service."},{"title":"What makes this different from Payload or Strapi?","description":"Kide runs inside your Astro app: same process, same deployment. No separate API server, no external database to manage in development. Relations return IDs, not auto-populated documents, so queries are always predictable."},{"title":"Is it production-ready?","description":"The core features are solid: collections, fields, admin UI, drafts, versioning, i18n, access control, and caching. It is actively developed and used in real projects."},{"title":"Can I deploy anywhere?","description":"Yes. Kide supports both Node.js (with SQLite) and Cloudflare Workers (with D1 and R2). The setup script lets you choose your deployment target."}]}],"_status":"published"}','2026-03-24T20:03:56.787Z');
INSERT INTO cms_pages_versions VALUES('YP0jFNLLDhgzY5gcRd9yl','Jbd6OotCGag_ViGHIrD3q',1,'{"title":"Features","slug":"features","summary":"A closer look at what Kide CMS offers out of the box.","blocks":[{"type":"text","heading":"Everything you need, nothing you don''t","content":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS ships with a complete feature set for building content-driven websites. Every feature is designed to work together seamlessly while staying simple enough to understand and customize."}]}]}},{"type":"faq","heading":"Core features","items":[{"title":"Collections and fields","description":"Define any content structure with 13 field types: text, slug, email, number, boolean, date, select, richText, image, relation, array, json, and blocks."},{"title":"Admin panel","description":"A full-featured admin UI that renders from your schema. Includes data tables with sorting and search, inline editing, keyboard shortcuts, and dark mode."},{"title":"Drafts and publishing","description":"Save drafts without affecting the public site. Schedule content to publish and unpublish at specific times. Discard changes to revert to the published version."},{"title":"Version history","description":"Every save creates a version. Restore any previous version with one click."},{"title":"Internationalization","description":"Per-field translation support. Mark fields as translatable and manage translations side-by-side in the admin UI."},{"title":"Asset management","description":"Upload, organize, and optimize images. Folder organization, focal point cropping, and automatic format conversion."},{"title":"Access control","description":"Role-based permissions per collection and per operation. Field-level access rules for fine-grained control."}]}],"_status":"published"}','2026-03-24T20:03:56.787Z');
CREATE TABLE `cms_posts` (
	`_id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`slug` text,
	`excerpt` text,
	`image` text,
	`body` text,
	`category` text,
	`author` text,
	`seo_description` text,
	`_status` text DEFAULT 'draft' NOT NULL,
	`_published_at` text,
	`_publish_at` text,
	`_unpublish_at` text,
	`_published` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
INSERT INTO cms_posts VALUES('U3VmILB21zuCicKYDQfO6','Getting Started with Kide CMS','getting-started-with-kide-cms','Everything you need to know to set up your first project with Kide CMS and start managing content.',NULL,'{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS is a code-first content management system built inside Astro. It takes a different approach from traditional CMSes: instead of configuring everything through a GUI, you define your content schema in TypeScript."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Why code-first?"}]},{"type":"paragraph","children":[{"type":"text","value":"Code-first means your content model is version-controlled, reviewable in pull requests, and can be reasoned about by both humans and AI agents. There is no hidden configuration; everything is in your codebase."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Quick setup"}]},{"type":"paragraph","children":[{"type":"text","value":"Run "},{"type":"text","value":"pnpx create-kide-app my-site","bold":true},{"type":"text","value":" and you will have a working CMS in under a minute. The admin panel is at "},{"type":"text","value":"/admin","bold":true},{"type":"text","value":"."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"What you get"}]},{"type":"list","ordered":false,"children":[{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"A runtime admin UI with field editors, data tables, and preview"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Drafts, publishing, scheduling, and version history"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Internationalization with per-field translation tables"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Asset management with folders and focal point cropping"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Access control with role-based permissions"}]}]}]}]}','technology','author_leo',NULL,'published','2026-03-24T20:03:56.783Z',NULL,NULL,NULL,'2026-03-24T20:03:56.783Z','2026-03-24T20:03:56.783Z');
INSERT INTO cms_posts VALUES('cE_bhizEo1kn1AJGSLywh','Designing Content Models That Scale','designing-content-models-that-scale','How to structure your collections, fields, and relations so your content architecture grows with your project.',NULL,'{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"A well-designed content model is the foundation of any CMS project. Get it right and adding features is straightforward. Get it wrong and you will be fighting your own schema."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Start with the output"}]},{"type":"paragraph","children":[{"type":"text","value":"Before defining collections, sketch the pages you need to render. What content appears on each page? What is shared across pages? This tells you which fields belong on which collections, and where relations make sense."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Keep it flat"}]},{"type":"paragraph","children":[{"type":"text","value":"Resist the urge to nest everything. A post with an author relation is simpler than a post with an embedded author object. Relations keep your data normalized and your queries predictable."}]},{"type":"quote","children":[{"type":"paragraph","children":[{"type":"text","value":"The best content model is the one that makes the common case simple and the edge case possible.","italic":true}]}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Use blocks for flexible layouts"}]},{"type":"paragraph","children":[{"type":"text","value":"When a page needs a mix of content types (hero sections, text blocks, FAQs), use the blocks field type. Each block type has its own schema, and editors can compose pages freely without developer intervention."}]}]}','design','author_anna',NULL,'published','2026-03-24T20:03:56.783Z',NULL,NULL,NULL,'2026-03-24T20:03:56.783Z','2026-03-24T20:03:56.783Z');
INSERT INTO cms_posts VALUES('YF_r5UhzQSzd2_3mzvUWK','The Local API Pattern','the-local-api-pattern','Why Kide CMS uses plain function calls instead of HTTP endpoints for content operations.',NULL,'{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Most headless CMSes force you to fetch content over HTTP, even when the CMS and the frontend run in the same process. Kide CMS takes a different approach."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Import, don''t fetch"}]},{"type":"paragraph","children":[{"type":"text","value":"With Kide, content operations are plain TypeScript imports: "},{"type":"text","value":"cms.posts.find()","bold":true},{"type":"text","value":" is a direct function call, not an HTTP round-trip. No serialization overhead, no network latency, full type safety."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"When HTTP is needed"}]},{"type":"paragraph","children":[{"type":"text","value":"The admin UI runs as React islands that need to talk to the server. For this, a thin HTTP layer wraps the same local API. But your public pages never go through HTTP; they call the API directly."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Benefits"}]},{"type":"list","ordered":false,"children":[{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Zero network overhead for server-rendered pages"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Full TypeScript types from schema to template"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Same API for admin and public, no duplication"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Easy to test with plain function calls"}]}]}]}]}','technology','author_leo',NULL,'published','2026-03-24T20:03:56.784Z',NULL,NULL,NULL,'2026-03-24T20:03:56.784Z','2026-03-24T20:03:56.784Z');
INSERT INTO cms_posts VALUES('EA_jnX3WVVtMIXcnu0-xU','Deploying to Cloudflare','deploying-to-cloudflare','A step-by-step guide to deploying your Kide CMS site on Cloudflare Workers with D1 and R2.',NULL,'{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS supports Cloudflare Workers as a deployment target. This gives you edge rendering, a globally distributed database with D1, and asset storage with R2, all on Cloudflare''s infrastructure."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Prerequisites"}]},{"type":"list","ordered":false,"children":[{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"A Cloudflare account"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Wrangler CLI installed"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"A Kide CMS project created with the Cloudflare template"}]}]}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Setting up resources"}]},{"type":"paragraph","children":[{"type":"text","value":"The setup script creates a wrangler.toml with D1 and R2 bindings. You need to create these resources on Cloudflare and add their IDs to the config."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Database migrations"}]},{"type":"paragraph","children":[{"type":"text","value":"Push your schema to the remote D1 database using the migration SQL file. This creates all the tables your collections need."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Deploy"}]},{"type":"paragraph","children":[{"type":"text","value":"Run "},{"type":"text","value":"pnpm run deploy","bold":true},{"type":"text","value":" and your site is live on the edge. The admin panel works the same way; it''s all one worker."}]}]}','technology','author_eero',NULL,'published','2026-03-24T20:03:56.784Z',NULL,NULL,NULL,'2026-03-24T20:03:56.784Z','2026-03-24T20:03:56.784Z');
INSERT INTO cms_posts VALUES('1A1MMUC2NgppI8WUH6JTx','Building Custom Block Types','building-custom-block-types','How to create rich, composable page layouts with custom block components in Kide CMS.',NULL,'{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Blocks are one of the most powerful features in Kide CMS. They let editors build flexible page layouts from predefined content types, while developers maintain full control over the rendering."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Defining block types"}]},{"type":"paragraph","children":[{"type":"text","value":"Block types are defined in your collection config. Each type has its own set of fields: a hero block might have a heading, body text, and a CTA link, while an FAQ block has a list of question-answer pairs."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Custom Astro components"}]},{"type":"paragraph","children":[{"type":"text","value":"Create an Astro component in src/components/blocks/ matching the block type name. The BlockRenderer automatically discovers and uses it. If no custom component exists, the built-in generic renderer handles it."}]},{"type":"heading","level":3,"children":[{"type":"text","value":"Example: Hero block"}]},{"type":"paragraph","children":[{"type":"text","value":"A Hero.astro component receives the block''s fields as props. You have full control over the markup, styles, and any additional logic like image optimization."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Best practices"}]},{"type":"list","ordered":false,"children":[{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Keep block types focused: one purpose per block"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Use text fields for short content, richText for long-form"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"The JSON field with the repeater component works great for lists"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Test your blocks with the preview feature before publishing"}]}]}]}]}','design','author_anna',NULL,'published','2026-03-24T20:03:56.785Z',NULL,NULL,NULL,'2026-03-24T20:03:56.785Z','2026-03-24T20:03:56.785Z');
INSERT INTO cms_posts VALUES('BTHUpELqCGpHfttzqWCUr','Access Control and Roles','access-control-and-roles','How to set up role-based permissions to control who can read, create, update, and publish content.',NULL,'{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS has a flexible access control system that lets you define rules per collection and per operation. Rules are plain functions that receive the current user and the document being accessed."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Defining access rules"}]},{"type":"paragraph","children":[{"type":"text","value":"Access rules live in src/cms/access.ts. Each collection can have rules for read, create, update, delete, and publish operations. If no rule is defined, the operation is allowed by default."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Role-based patterns"}]},{"type":"paragraph","children":[{"type":"text","value":"The most common pattern is checking the user''s role. Editors might be allowed to create and update posts but not delete them. Admins have full access. Public users can only read published content."}]},{"type":"quote","children":[{"type":"paragraph","children":[{"type":"text","value":"Access control should be invisible when it''s working. Users should only notice it when they try something they shouldn''t.","italic":true}]}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Field-level access"}]},{"type":"paragraph","children":[{"type":"text","value":"For fine-grained control, individual fields can have their own access rules. This is useful for sensitive fields like SEO metadata that only certain roles should edit."}]}]}','technology','author_leo',NULL,'draft',NULL,NULL,NULL,NULL,'2026-03-24T20:03:56.785Z','2026-03-24T20:03:56.785Z');
CREATE TABLE `cms_posts_translations` (
	`_id` text PRIMARY KEY NOT NULL,
	`_entity_id` text NOT NULL,
	`_language_code` text NOT NULL,
	`title` text NOT NULL,
	`slug` text,
	`excerpt` text,
	`body` text,
	`seo_description` text,
	FOREIGN KEY (`_entity_id`) REFERENCES `cms_posts`(`_id`) ON UPDATE no action ON DELETE cascade
);
CREATE TABLE `cms_posts_versions` (
	`_id` text PRIMARY KEY NOT NULL,
	`_doc_id` text NOT NULL,
	`_version` integer NOT NULL,
	`_snapshot` text NOT NULL,
	`_created_at` text NOT NULL,
	FOREIGN KEY (`_doc_id`) REFERENCES `cms_posts`(`_id`) ON UPDATE no action ON DELETE cascade
);
INSERT INTO cms_posts_versions VALUES('jIq7neOrTOf1T-Iddi1kn','U3VmILB21zuCicKYDQfO6',1,'{"title":"Getting Started with Kide CMS","slug":"getting-started-with-kide-cms","excerpt":"Everything you need to know to set up your first project with Kide CMS and start managing content.","body":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS is a code-first content management system built inside Astro. It takes a different approach from traditional CMSes: instead of configuring everything through a GUI, you define your content schema in TypeScript."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Why code-first?"}]},{"type":"paragraph","children":[{"type":"text","value":"Code-first means your content model is version-controlled, reviewable in pull requests, and can be reasoned about by both humans and AI agents. There is no hidden configuration; everything is in your codebase."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Quick setup"}]},{"type":"paragraph","children":[{"type":"text","value":"Run "},{"type":"text","value":"pnpx create-kide-app my-site","bold":true},{"type":"text","value":" and you will have a working CMS in under a minute. The admin panel is at "},{"type":"text","value":"/admin","bold":true},{"type":"text","value":"."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"What you get"}]},{"type":"list","ordered":false,"children":[{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"A runtime admin UI with field editors, data tables, and preview"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Drafts, publishing, scheduling, and version history"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Internationalization with per-field translation tables"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Asset management with folders and focal point cropping"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Access control with role-based permissions"}]}]}]}]},"category":"technology","author":"author_leo","sortOrder":50,"_status":"published"}','2026-03-24T20:03:56.783Z');
INSERT INTO cms_posts_versions VALUES('B4IMI3ZnZ-Qg-Nmwcf4qg','cE_bhizEo1kn1AJGSLywh',1,'{"title":"Designing Content Models That Scale","slug":"designing-content-models-that-scale","excerpt":"How to structure your collections, fields, and relations so your content architecture grows with your project.","body":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"A well-designed content model is the foundation of any CMS project. Get it right and adding features is straightforward. Get it wrong and you will be fighting your own schema."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Start with the output"}]},{"type":"paragraph","children":[{"type":"text","value":"Before defining collections, sketch the pages you need to render. What content appears on each page? What is shared across pages? This tells you which fields belong on which collections, and where relations make sense."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Keep it flat"}]},{"type":"paragraph","children":[{"type":"text","value":"Resist the urge to nest everything. A post with an author relation is simpler than a post with an embedded author object. Relations keep your data normalized and your queries predictable."}]},{"type":"quote","children":[{"type":"paragraph","children":[{"type":"text","value":"The best content model is the one that makes the common case simple and the edge case possible.","italic":true}]}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Use blocks for flexible layouts"}]},{"type":"paragraph","children":[{"type":"text","value":"When a page needs a mix of content types (hero sections, text blocks, FAQs), use the blocks field type. Each block type has its own schema, and editors can compose pages freely without developer intervention."}]}]},"category":"design","author":"author_anna","sortOrder":40,"_status":"published"}','2026-03-24T20:03:56.783Z');
INSERT INTO cms_posts_versions VALUES('2f3Xn1AZZk4HB6ESQWGvB','YF_r5UhzQSzd2_3mzvUWK',1,'{"title":"The Local API Pattern","slug":"the-local-api-pattern","excerpt":"Why Kide CMS uses plain function calls instead of HTTP endpoints for content operations.","body":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Most headless CMSes force you to fetch content over HTTP, even when the CMS and the frontend run in the same process. Kide CMS takes a different approach."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Import, don''t fetch"}]},{"type":"paragraph","children":[{"type":"text","value":"With Kide, content operations are plain TypeScript imports: "},{"type":"text","value":"cms.posts.find()","bold":true},{"type":"text","value":" is a direct function call, not an HTTP round-trip. No serialization overhead, no network latency, full type safety."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"When HTTP is needed"}]},{"type":"paragraph","children":[{"type":"text","value":"The admin UI runs as React islands that need to talk to the server. For this, a thin HTTP layer wraps the same local API. But your public pages never go through HTTP; they call the API directly."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Benefits"}]},{"type":"list","ordered":false,"children":[{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Zero network overhead for server-rendered pages"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Full TypeScript types from schema to template"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Same API for admin and public, no duplication"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Easy to test with plain function calls"}]}]}]}]},"category":"technology","author":"author_leo","sortOrder":30,"_status":"published"}','2026-03-24T20:03:56.784Z');
INSERT INTO cms_posts_versions VALUES('mysqUd296bx-cSLYLVr8c','EA_jnX3WVVtMIXcnu0-xU',1,'{"title":"Deploying to Cloudflare","slug":"deploying-to-cloudflare","excerpt":"A step-by-step guide to deploying your Kide CMS site on Cloudflare Workers with D1 and R2.","body":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS supports Cloudflare Workers as a deployment target. This gives you edge rendering, a globally distributed database with D1, and asset storage with R2, all on Cloudflare''s infrastructure."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Prerequisites"}]},{"type":"list","ordered":false,"children":[{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"A Cloudflare account"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Wrangler CLI installed"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"A Kide CMS project created with the Cloudflare template"}]}]}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Setting up resources"}]},{"type":"paragraph","children":[{"type":"text","value":"The setup script creates a wrangler.toml with D1 and R2 bindings. You need to create these resources on Cloudflare and add their IDs to the config."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Database migrations"}]},{"type":"paragraph","children":[{"type":"text","value":"Push your schema to the remote D1 database using the migration SQL file. This creates all the tables your collections need."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Deploy"}]},{"type":"paragraph","children":[{"type":"text","value":"Run "},{"type":"text","value":"pnpm run deploy","bold":true},{"type":"text","value":" and your site is live on the edge. The admin panel works the same way; it''s all one worker."}]}]},"category":"technology","author":"author_eero","sortOrder":20,"_status":"published"}','2026-03-24T20:03:56.784Z');
INSERT INTO cms_posts_versions VALUES('26uxikoa-q9bpoo0Bpgvn','1A1MMUC2NgppI8WUH6JTx',1,'{"title":"Building Custom Block Types","slug":"building-custom-block-types","excerpt":"How to create rich, composable page layouts with custom block components in Kide CMS.","body":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Blocks are one of the most powerful features in Kide CMS. They let editors build flexible page layouts from predefined content types, while developers maintain full control over the rendering."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Defining block types"}]},{"type":"paragraph","children":[{"type":"text","value":"Block types are defined in your collection config. Each type has its own set of fields: a hero block might have a heading, body text, and a CTA link, while an FAQ block has a list of question-answer pairs."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Custom Astro components"}]},{"type":"paragraph","children":[{"type":"text","value":"Create an Astro component in src/components/blocks/ matching the block type name. The BlockRenderer automatically discovers and uses it. If no custom component exists, the built-in generic renderer handles it."}]},{"type":"heading","level":3,"children":[{"type":"text","value":"Example: Hero block"}]},{"type":"paragraph","children":[{"type":"text","value":"A Hero.astro component receives the block''s fields as props. You have full control over the markup, styles, and any additional logic like image optimization."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Best practices"}]},{"type":"list","ordered":false,"children":[{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Keep block types focused: one purpose per block"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Use text fields for short content, richText for long-form"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"The JSON field with the repeater component works great for lists"}]}]},{"type":"list-item","children":[{"type":"paragraph","children":[{"type":"text","value":"Test your blocks with the preview feature before publishing"}]}]}]}]},"category":"design","author":"author_anna","sortOrder":10,"_status":"published"}','2026-03-24T20:03:56.785Z');
INSERT INTO cms_posts_versions VALUES('wRJmwd74v_EIYC8cnIPxo','BTHUpELqCGpHfttzqWCUr',1,'{"title":"Access Control and Roles","slug":"access-control-and-roles","excerpt":"How to set up role-based permissions to control who can read, create, update, and publish content.","body":{"type":"root","children":[{"type":"paragraph","children":[{"type":"text","value":"Kide CMS has a flexible access control system that lets you define rules per collection and per operation. Rules are plain functions that receive the current user and the document being accessed."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Defining access rules"}]},{"type":"paragraph","children":[{"type":"text","value":"Access rules live in src/cms/access.ts. Each collection can have rules for read, create, update, delete, and publish operations. If no rule is defined, the operation is allowed by default."}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Role-based patterns"}]},{"type":"paragraph","children":[{"type":"text","value":"The most common pattern is checking the user''s role. Editors might be allowed to create and update posts but not delete them. Admins have full access. Public users can only read published content."}]},{"type":"quote","children":[{"type":"paragraph","children":[{"type":"text","value":"Access control should be invisible when it''s working. Users should only notice it when they try something they shouldn''t.","italic":true}]}]},{"type":"heading","level":2,"children":[{"type":"text","value":"Field-level access"}]},{"type":"paragraph","children":[{"type":"text","value":"For fine-grained control, individual fields can have their own access rules. This is useful for sensitive fields like SEO metadata that only certain roles should edit."}]}]},"category":"technology","author":"author_leo","sortOrder":5,"_status":"draft"}','2026-03-24T20:03:56.785Z');
CREATE TABLE `cms_sessions` (
	`_id` text PRIMARY KEY NOT NULL,
	`user_id` text NOT NULL,
	`expires_at` text NOT NULL
);
INSERT INTO cms_sessions VALUES('EPi3llMrqCvcVE0oNtBFeqRnFscM51nP','MAJpygR-tOdCUrKDdpuNO','2026-04-23T20:04:22.097Z');
CREATE TABLE `cms_taxonomies` (
	`_id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`slug` text,
	`terms` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
INSERT INTO cms_taxonomies VALUES('z6OkoBpGhPhdplzf_optm','Categories','categories','[{"id":"t1","name":"Technology","slug":"technology","children":[{"id":"t2","name":"Frontend","slug":"frontend","children":[]},{"id":"t3","name":"Backend","slug":"backend","children":[]},{"id":"t9","name":"DevOps","slug":"devops","children":[]}]},{"id":"t4","name":"Design","slug":"design","children":[{"id":"t10","name":"UI Design","slug":"ui-design","children":[]},{"id":"t11","name":"UX Research","slug":"ux-research","children":[]}]},{"id":"t5","name":"Business","slug":"business","children":[]}]','2026-03-24T20:03:56.786Z','2026-03-24T20:03:56.786Z');
INSERT INTO cms_taxonomies VALUES('pC-v-yXCn-nWyOERxOdEv','Tags','tags','[{"id":"t6","name":"Astro","slug":"astro","children":[]},{"id":"t7","name":"CMS","slug":"cms","children":[]},{"id":"t8","name":"Open Source","slug":"open-source","children":[]},{"id":"t12","name":"TypeScript","slug":"typescript","children":[]},{"id":"t13","name":"Tutorial","slug":"tutorial","children":[]},{"id":"t14","name":"Cloudflare","slug":"cloudflare","children":[]},{"id":"t15","name":"Deployment","slug":"deployment","children":[]}]','2026-03-24T20:03:56.786Z','2026-03-24T20:03:56.786Z');
CREATE TABLE `cms_taxonomies_translations` (
	`_id` text PRIMARY KEY NOT NULL,
	`_entity_id` text NOT NULL,
	`_language_code` text NOT NULL,
	`terms` text,
	FOREIGN KEY (`_entity_id`) REFERENCES `cms_taxonomies`(`_id`) ON UPDATE no action ON DELETE cascade
);
CREATE TABLE `cms_users` (
	`_id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`email` text NOT NULL,
	`role` text DEFAULT 'editor',
	`password` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
INSERT INTO cms_users VALUES('MAJpygR-tOdCUrKDdpuNO','Matti Hernesniemi','zernobillyguy@gmail.com','admin','pbkdf2:100000:5zO8aqUOJdnHcjZYjNrONw==:GkeZFWq0kemFyrXt7OxbDXGxL0DFYCAKIQjmnsWnjc4=','2026-03-24T20:04:22.065Z','2026-03-24T20:04:22.065Z');
CREATE UNIQUE INDEX `cms_authors_slug_unique` ON `cms_authors` (`slug`);
CREATE UNIQUE INDEX `cms_authors_translations__entity_id__language_code_unique` ON `cms_authors_translations` (`_entity_id`,`_language_code`);
CREATE UNIQUE INDEX `cms_front_page_translations__entity_id__language_code_unique` ON `cms_front_page_translations` (`_entity_id`,`_language_code`);
CREATE UNIQUE INDEX `cms_invites_token_unique` ON `cms_invites` (`token`);
CREATE UNIQUE INDEX `cms_menus_slug_unique` ON `cms_menus` (`slug`);
CREATE UNIQUE INDEX `cms_menus_translations__entity_id__language_code_unique` ON `cms_menus_translations` (`_entity_id`,`_language_code`);
CREATE UNIQUE INDEX `cms_pages_slug_unique` ON `cms_pages` (`slug`);
CREATE UNIQUE INDEX `cms_pages_translations_slug_unique` ON `cms_pages_translations` (`slug`);
CREATE UNIQUE INDEX `cms_pages_translations__entity_id__language_code_unique` ON `cms_pages_translations` (`_entity_id`,`_language_code`);
CREATE UNIQUE INDEX `cms_posts_slug_unique` ON `cms_posts` (`slug`);
CREATE UNIQUE INDEX `cms_posts_translations_slug_unique` ON `cms_posts_translations` (`slug`);
CREATE UNIQUE INDEX `cms_posts_translations__entity_id__language_code_unique` ON `cms_posts_translations` (`_entity_id`,`_language_code`);
CREATE UNIQUE INDEX `cms_taxonomies_slug_unique` ON `cms_taxonomies` (`slug`);
CREATE UNIQUE INDEX `cms_taxonomies_translations__entity_id__language_code_unique` ON `cms_taxonomies_translations` (`_entity_id`,`_language_code`);
CREATE UNIQUE INDEX `cms_users_email_unique` ON `cms_users` (`email`);
