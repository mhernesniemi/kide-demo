import { defineMiddleware } from "astro:middleware";

// ── Read-only demo gate ──────────────────────────────────────────────
// Everyone is auto-signed-in as a demo admin (see admin.auth in
// src/cms/cms.config.ts), and every state-changing CMS API call is blocked
// here. This middleware runs after the CMS auth middleware (registered with
// order "pre"), so the session is already resolved by the time we run.

const READ_ONLY_MSG = "This is a read-only demo";

const isFormRequest = (request: Request) => {
  const ct = request.headers.get("content-type") ?? "";
  return ct.includes("application/x-www-form-urlencoded") || ct.includes("multipart/form-data");
};

export const onRequest = defineMiddleware(async (context, next) => {
  const { pathname } = context.url;
  const { method } = context.request;

  // The login page has nothing to do — visitors are already "signed in"
  if (pathname === "/admin/login") {
    return context.redirect("/admin");
  }

  // Logout → public site instead of the login page
  if (pathname === "/api/cms/auth/logout") {
    return new Response(null, { status: 303, headers: { Location: "/" } });
  }

  // Block all write API calls. Auth routes are exempt (harmless with the fake
  // session); cron endpoints run as GET with their own bearer auth.
  if (pathname.startsWith("/api/cms") && method !== "GET" && !pathname.startsWith("/api/cms/auth/")) {
    // Form submissions → redirect back with toast
    if (isFormRequest(context.request)) {
      const referer = context.request.headers.get("referer");
      const redirectTo = referer ? new URL(referer).pathname : "/admin";
      const sep = redirectTo.includes("?") ? "&" : "?";
      return new Response(null, {
        status: 303,
        headers: { Location: `${redirectTo}${sep}_toast=error&_msg=${encodeURIComponent(READ_ONLY_MSG)}` },
      });
    }

    // Fetch/JSON requests → 403 JSON
    return Response.json({ error: READ_ONLY_MSG, readOnly: true }, { status: 403 });
  }

  return next();
});
