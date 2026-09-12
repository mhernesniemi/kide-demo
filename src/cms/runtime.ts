import {
  configureCmsRuntime,
  initSchema,
  createCms,
  assets,
  folders,
  stripMissingAssetImages,
  findAssetUsage,
  countAssetUsage,
  AssetInUseError,
  hashPassword,
  verifyPassword,
  hashToken,
  createSession,
  validateSession,
  destroySession,
  createInvite,
  validateInvite,
  consumeInvite,
  createPasswordReset,
  validatePasswordReset,
  consumePasswordReset,
  SESSION_COOKIE_NAME,
  setSessionCookie,
  clearSessionCookie,
  acquireLock,
  releaseLock,
  recordAudit,
  logAudit,
  pruneAuditLog,
  auditRequestMeta,
  tokenReference,
  collaboration,
  search,
  indexDocument,
  removeDocument,
  reindexAll,
  isAiEnabled,
  getAiModel,
  getEmail,
  streamAltText,
  streamSeoDescription,
  streamTranslation,
  readEnv,
  peekRateLimit,
  hitRateLimit,
  recordRateLimit,
  clearRateLimit,
  pruneRateLimits,
} from "@kidecms/core";
import type { SessionUser } from "@kidecms/core";
import { DEMO_USER } from "./demo";

import * as schema from "./.generated/schema";
import { closeDb, getDb } from "./adapters/db";
import { deleteFile, getFile, getFileStream, putFile } from "./adapters/storage";
import { isEmailConfigured, sendInviteEmail, sendPasswordResetEmail } from "./adapters/email";

let initialized = false;

export const initCmsRuntime = () => {
  if (initialized) return;

  initSchema(schema);
  configureCmsRuntime({
    getDb,
    closeDb,
    storage: { putFile, getFile, deleteFile, getFileStream },
    email: { sendInviteEmail, sendPasswordResetEmail, isEmailConfigured },
    env: (key) =>
      (import.meta as ImportMeta & { env?: Record<string, string | undefined> }).env?.[key] ?? process.env[key],
  });

  initialized = true;
};

initCmsRuntime();

// Read-only demo: core's ?preview check reads the session from here rather than
// the custom auth provider, so return the demo user too.
const getSessionUser = async (_request: Request): Promise<SessionUser | null> => DEMO_USER;

export {
  createCms,
  assets,
  folders,
  stripMissingAssetImages,
  findAssetUsage,
  countAssetUsage,
  AssetInUseError,
  hashPassword,
  verifyPassword,
  hashToken,
  createSession,
  validateSession,
  destroySession,
  getSessionUser,
  createInvite,
  validateInvite,
  consumeInvite,
  createPasswordReset,
  validatePasswordReset,
  consumePasswordReset,
  SESSION_COOKIE_NAME,
  setSessionCookie,
  clearSessionCookie,
  acquireLock,
  releaseLock,
  recordAudit,
  logAudit,
  pruneAuditLog,
  auditRequestMeta,
  tokenReference,
  collaboration,
  search,
  indexDocument,
  removeDocument,
  reindexAll,
  isAiEnabled,
  getAiModel,
  getEmail,
  streamAltText,
  streamSeoDescription,
  streamTranslation,
  readEnv,
  peekRateLimit,
  hitRateLimit,
  recordRateLimit,
  clearRateLimit,
  pruneRateLimits,
};
