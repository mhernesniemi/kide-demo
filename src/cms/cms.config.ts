import { customAuth, defineConfig } from "@kidecms/core";
import users from "./collections/users";
import frontPage from "./collections/front-page";
import pages from "./collections/pages";
import posts from "./collections/posts";
import taxonomies from "./collections/taxonomies";
import menus from "./collections/menus";
import forms from "./collections/forms";
import formSubmissions from "./collections/form-submissions";

export default defineConfig({
  locales: {
    default: "en",
    supported: ["en"],
  },
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
  collections: [users, frontPage, pages, posts, taxonomies, menus, forms, formSubmissions],
});
