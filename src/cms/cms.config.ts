import { customAuth, defineConfig } from "@/cms/core";
import users from "./collections/users";
import authors from "./collections/authors";
import posts from "./collections/posts";
import taxonomies from "./collections/taxonomies";
import menus from "./collections/menus";
import frontPage from "./collections/front-page";
import pages from "./collections/pages";
import sharedSections from "./collections/shared-sections";
import forms from "./collections/forms";
import formSubmissions from "./collections/form-submissions";

export default defineConfig({
  database: { dialect: "sqlite" },
  admin: {
    auth: {
      // Read-only demo: everyone is signed in as the demo admin. All write
      // API calls are blocked in src/middleware.ts.
      provider: customAuth({
        kind: "custom",
        getSession: async () => ({
          id: "demo",
          email: "demo@example.com",
          name: "Demo User",
          role: "admin",
        }),
      }),
    },
  },
  locales: {
    default: "en",
    supported: ["en"],
  },
  collections: [users, authors, posts, taxonomies, menus, frontPage, pages, sharedSections, forms, formSubmissions],
});
