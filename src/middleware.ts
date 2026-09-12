import { defineMiddleware } from "astro:middleware";

// ── Read-only demo gate ──────────────────────────────────────────────
// Everyone is auto-signed-in as a demo admin (see admin.auth in
// src/cms/cms.config.ts), and every state-changing CMS API call is blocked
// here. This middleware runs after the CMS auth middleware (registered with
// order "pre"), so the session is already resolved by the time we run.

const READ_ONLY_MSG = "This is a read-only demo";

// Native <form> submits navigate; admin components also fetch() with
// form-encoded bodies, and a redirect there would be followed and read as success.
const isFormNavigation = (request: Request) => {
  const ct = request.headers.get("content-type") ?? "";
  const isForm = ct.includes("application/x-www-form-urlencoded") || ct.includes("multipart/form-data");
  return isForm && request.headers.get("sec-fetch-mode") === "navigate";
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

  // Block all write API calls, auth routes included (setup/invite would write
  // users). Live preview rendering is the only read-only POST.
  const isWrite = method !== "GET" && method !== "HEAD" && method !== "OPTIONS";
  if (pathname.startsWith("/api/cms") && isWrite && pathname !== "/api/cms/preview/render") {
    // Form submissions → redirect back with toast
    if (isFormNavigation(context.request)) {
      const referer = context.request.headers.get("referer");
      const redirectTo = referer ? new URL(referer).pathname : "/admin";
      return new Response(null, {
        status: 303,
        headers: { Location: `${redirectTo}?_toast=error&_msg=${encodeURIComponent(READ_ONLY_MSG)}` },
      });
    }

    // Fetch/JSON requests → 403 JSON
    return Response.json({ error: READ_ONLY_MSG, readOnly: true }, { status: 403 });
  }

  return next();
});
