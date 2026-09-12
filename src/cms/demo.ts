// Read-only demo: every visitor is this admin. Used by the custom auth provider
// (src/cms/cms.config.ts) and the runtime's getSessionUser (src/cms/runtime.ts),
// which core still consults for ?preview access. Writes are blocked in
// src/middleware.ts.
export const DEMO_USER = {
  id: "demo",
  email: "demo@example.com",
  name: "Demo User",
  role: "admin",
};
