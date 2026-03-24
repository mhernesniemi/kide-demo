import { defineMiddleware } from "astro:middleware";
import { getSessionUser } from "./cms/core/auth";
import { getDb } from "./cms/core/db";

let hasUsers: boolean | null = null;

export const resetUserCache = () => {
  hasUsers = null;
};

const DEMO_READ_ONLY = true;
const READ_ONLY_MSG = "This is a read-only demo";

const isFormRequest = (request: Request) => {
  const ct = request.headers.get("content-type") ?? "";
  return ct.includes("application/x-www-form-urlencoded") || ct.includes("multipart/form-data");
};

export const onRequest = defineMiddleware(async (context, next) => {
  const { pathname } = context.url;
  const { method } = context.request;

  // Skip auth for public pages and static assets
  const isAdminRoute = pathname.startsWith("/admin");
  const isAdminApiRoute = pathname.startsWith("/api/cms");
  const isLoginPage = pathname === "/admin/login";
  const isLoginApi = pathname === "/api/cms/auth/login";
  const isSetupPage = pathname === "/admin/setup";
  const isSetupApi = pathname === "/api/cms/auth/setup";
  const isInvitePage = pathname === "/admin/invite";
  const isInviteApi = pathname === "/api/cms/auth/invite";

  if (!isAdminRoute && !isAdminApiRoute) {
    return next();
  }

  // ── Read-only demo guard ────────────────────────────────────────────
  if (DEMO_READ_ONLY) {
    // Redirect login page → straight to admin
    if (isLoginPage) {
      return context.redirect("/admin");
    }

    // Logout → redirect to public site instead of login
    if (pathname === "/api/cms/auth/logout") {
      return new Response(null, { status: 303, headers: { Location: "/" } });
    }

    // Block all write API calls (except auth and locks)
    if (isAdminApiRoute && method !== "GET") {
      const isAuthRoute = pathname.startsWith("/api/cms/auth/");
      const isLockRoute = pathname.startsWith("/api/cms/locks/");

      if (!isAuthRoute && !isLockRoute) {
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
    }
  }

  // Check if any users exist (cached after first check)
  if (hasUsers === null || !hasUsers) {
    try {
      const db = await getDb();
      const schema = await import("./cms/.generated/schema");
      const tables = schema.cmsTables as Record<string, { main: any }>;
      if (tables.users) {
        const rows = await db.select().from(tables.users.main).limit(1);
        hasUsers = rows.length > 0;
      } else {
        hasUsers = true;
      }
    } catch {
      // Tables may not exist yet (first run, schema not pushed)
      hasUsers = false;
    }
  }

  // No users yet — redirect to setup
  if (!hasUsers) {
    if (isSetupPage || isSetupApi) return next();
    if (isAdminApiRoute) {
      return new Response(JSON.stringify({ error: "Setup required" }), { status: 403 });
    }
    return context.redirect("/admin/setup");
  }

  // After setup, always allow setup API (it self-guards) but redirect setup page to login
  if (isSetupPage) {
    return context.redirect("/admin/login");
  }

  // Always allow login page, login API, and cron endpoint (has its own auth)
  const isCronApi = pathname === "/api/cms/cron/publish";
  if (isLoginPage || isLoginApi || isSetupApi || isCronApi || isInvitePage || isInviteApi) {
    return next();
  }

  const user = await getSessionUser(context.request);

  if (!user) {
    // In demo mode, inject a fake user so admin pages work without login
    if (DEMO_READ_ONLY) {
      context.locals.user = { id: "demo", email: "demo@example.com", name: "Demo User", role: "admin" };
      return next();
    }

    // API routes → 401
    if (isAdminApiRoute) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }
    // Admin pages → redirect to login
    return context.redirect("/admin/login");
  }

  // Attach user to locals for downstream use
  context.locals.user = user;

  return next();
});
