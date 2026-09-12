CREATE TABLE `cms_asset_folders` (
	`_id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`parent` text,
	`_created_at` text NOT NULL
);
--> statement-breakpoint
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
	`hash` text,
	`_created_at` text NOT NULL
);
--> statement-breakpoint
CREATE INDEX `assets_storage_path_idx` ON `cms_assets` (`storage_path`);--> statement-breakpoint
CREATE INDEX `assets_hash_idx` ON `cms_assets` (`hash`);--> statement-breakpoint
CREATE INDEX `assets_folder_idx` ON `cms_assets` (`folder`);--> statement-breakpoint
CREATE TABLE `cms_audit_log` (
	`_id` text PRIMARY KEY NOT NULL,
	`timestamp` integer NOT NULL,
	`actor_id` text,
	`actor_email` text,
	`actor_role` text,
	`action` text NOT NULL,
	`resource_type` text NOT NULL,
	`resource_collection` text,
	`resource_id` text,
	`ip_address` text,
	`user_agent` text
);
--> statement-breakpoint
CREATE INDEX `audit_timestamp_idx` ON `cms_audit_log` (`timestamp`);--> statement-breakpoint
CREATE INDEX `audit_actor_idx` ON `cms_audit_log` (`actor_id`);--> statement-breakpoint
CREATE INDEX `audit_resource_idx` ON `cms_audit_log` (`resource_type`,`resource_collection`,`resource_id`);--> statement-breakpoint
CREATE TABLE `cms_collaboration` (
	`collection` text NOT NULL,
	`document_id` text NOT NULL,
	`review_state` text NOT NULL,
	`editor` text,
	`updated_at` text NOT NULL,
	PRIMARY KEY(`collection`, `document_id`)
);
--> statement-breakpoint
CREATE INDEX `collaboration_editor_idx` ON `cms_collaboration` (`editor`);--> statement-breakpoint
CREATE INDEX `collaboration_review_state_idx` ON `cms_collaboration` (`review_state`);--> statement-breakpoint
CREATE TABLE `cms_comments` (
	`_id` text PRIMARY KEY NOT NULL,
	`collection` text NOT NULL,
	`document_id` text NOT NULL,
	`field` text,
	`body` text NOT NULL,
	`author_id` text,
	`author_email` text,
	`resolved` integer DEFAULT false NOT NULL,
	`created_at` text NOT NULL,
	`edited_at` text
);
--> statement-breakpoint
CREATE INDEX `comments_doc_idx` ON `cms_comments` (`collection`,`document_id`);--> statement-breakpoint
CREATE TABLE `cms_form_submissions` (
	`_id` text PRIMARY KEY NOT NULL,
	`label` text,
	`form` text NOT NULL,
	`status` text DEFAULT 'new',
	`data` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
--> statement-breakpoint
CREATE INDEX `form_submissions_updated_idx` ON `cms_form_submissions` (`_updated_at`);--> statement-breakpoint
CREATE TABLE `cms_forms` (
	`_id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`slug` text,
	`submit_redirect` text,
	`success_message` text DEFAULT 'Thanks — we got your message.',
	`notification_email` text,
	`fields` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `cms_forms_slug_unique` ON `cms_forms` (`slug`);--> statement-breakpoint
CREATE INDEX `forms_updated_idx` ON `cms_forms` (`_updated_at`);--> statement-breakpoint
CREATE TABLE `cms_front_page` (
	`_id` text PRIMARY KEY NOT NULL,
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
--> statement-breakpoint
CREATE INDEX `front_page_publish_idx` ON `cms_front_page` (`_status`,`_publish_at`);--> statement-breakpoint
CREATE INDEX `front_page_unpublish_idx` ON `cms_front_page` (`_status`,`_unpublish_at`);--> statement-breakpoint
CREATE INDEX `front_page_updated_idx` ON `cms_front_page` (`_updated_at`);--> statement-breakpoint
CREATE TABLE `cms_front_page_versions` (
	`_id` text PRIMARY KEY NOT NULL,
	`_doc_id` text NOT NULL,
	`_version` integer NOT NULL,
	`_snapshot` text NOT NULL,
	`_created_at` text NOT NULL,
	FOREIGN KEY (`_doc_id`) REFERENCES `cms_front_page`(`_id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE TABLE `cms_invites` (
	`_id` text PRIMARY KEY NOT NULL,
	`user_id` text NOT NULL,
	`token` text NOT NULL,
	`expires_at` text NOT NULL,
	`used_at` text
);
--> statement-breakpoint
CREATE UNIQUE INDEX `cms_invites_token_unique` ON `cms_invites` (`token`);--> statement-breakpoint
CREATE TABLE `cms_locks` (
	`_id` text PRIMARY KEY NOT NULL,
	`collection` text NOT NULL,
	`document_id` text NOT NULL,
	`user_id` text NOT NULL,
	`user_email` text NOT NULL,
	`locked_at` text NOT NULL
);
--> statement-breakpoint
CREATE INDEX `locks_doc_idx` ON `cms_locks` (`collection`,`document_id`);--> statement-breakpoint
CREATE TABLE `cms_menus` (
	`_id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`slug` text,
	`items` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `cms_menus_slug_unique` ON `cms_menus` (`slug`);--> statement-breakpoint
CREATE INDEX `menus_updated_idx` ON `cms_menus` (`_updated_at`);--> statement-breakpoint
CREATE TABLE `cms_outbox` (
	`_id` text PRIMARY KEY NOT NULL,
	`type` text NOT NULL,
	`payload` text,
	`status` text DEFAULT 'pending' NOT NULL,
	`attempts` integer DEFAULT 0 NOT NULL,
	`max_attempts` integer DEFAULT 5 NOT NULL,
	`next_attempt_at` integer NOT NULL,
	`dedupe_key` text,
	`last_error` text,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL
);
--> statement-breakpoint
CREATE INDEX `outbox_due_idx` ON `cms_outbox` (`status`,`next_attempt_at`);--> statement-breakpoint
CREATE INDEX `outbox_dedupe_idx` ON `cms_outbox` (`dedupe_key`);--> statement-breakpoint
CREATE TABLE `cms_pages` (
	`_id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`slug` text,
	`seo_description` text,
	`body` text,
	`_status` text DEFAULT 'draft' NOT NULL,
	`_published_at` text,
	`_publish_at` text,
	`_unpublish_at` text,
	`_published` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `cms_pages_slug_unique` ON `cms_pages` (`slug`);--> statement-breakpoint
CREATE INDEX `pages_publish_idx` ON `cms_pages` (`_status`,`_publish_at`);--> statement-breakpoint
CREATE INDEX `pages_unpublish_idx` ON `cms_pages` (`_status`,`_unpublish_at`);--> statement-breakpoint
CREATE INDEX `pages_updated_idx` ON `cms_pages` (`_updated_at`);--> statement-breakpoint
CREATE TABLE `cms_pages_versions` (
	`_id` text PRIMARY KEY NOT NULL,
	`_doc_id` text NOT NULL,
	`_version` integer NOT NULL,
	`_snapshot` text NOT NULL,
	`_created_at` text NOT NULL,
	FOREIGN KEY (`_doc_id`) REFERENCES `cms_pages`(`_id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE TABLE `cms_password_resets` (
	`_id` text PRIMARY KEY NOT NULL,
	`user_id` text NOT NULL,
	`token` text NOT NULL,
	`expires_at` text NOT NULL,
	`used_at` text
);
--> statement-breakpoint
CREATE UNIQUE INDEX `cms_password_resets_token_unique` ON `cms_password_resets` (`token`);--> statement-breakpoint
CREATE TABLE `cms_posts` (
	`_id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`slug` text,
	`excerpt` text,
	`image` text,
	`body` text,
	`category` text,
	`seo_description` text,
	`_status` text DEFAULT 'draft' NOT NULL,
	`_published_at` text,
	`_publish_at` text,
	`_unpublish_at` text,
	`_published` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `cms_posts_slug_unique` ON `cms_posts` (`slug`);--> statement-breakpoint
CREATE INDEX `posts_publish_idx` ON `cms_posts` (`_status`,`_publish_at`);--> statement-breakpoint
CREATE INDEX `posts_unpublish_idx` ON `cms_posts` (`_status`,`_unpublish_at`);--> statement-breakpoint
CREATE INDEX `posts_updated_idx` ON `cms_posts` (`_updated_at`);--> statement-breakpoint
CREATE TABLE `cms_posts_versions` (
	`_id` text PRIMARY KEY NOT NULL,
	`_doc_id` text NOT NULL,
	`_version` integer NOT NULL,
	`_snapshot` text NOT NULL,
	`_created_at` text NOT NULL,
	FOREIGN KEY (`_doc_id`) REFERENCES `cms_posts`(`_id`) ON UPDATE no action ON DELETE cascade
);
--> statement-breakpoint
CREATE TABLE `cms_rate_limits` (
	`_id` text PRIMARY KEY NOT NULL,
	`window_start` integer NOT NULL,
	`count` integer NOT NULL,
	`expires_at` integer NOT NULL
);
--> statement-breakpoint
CREATE INDEX `rate_limits_expiry_idx` ON `cms_rate_limits` (`expires_at`);--> statement-breakpoint
CREATE TABLE `cms_sessions` (
	`_id` text PRIMARY KEY NOT NULL,
	`user_id` text NOT NULL,
	`expires_at` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `cms_taxonomies` (
	`_id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`slug` text,
	`terms` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `cms_taxonomies_slug_unique` ON `cms_taxonomies` (`slug`);--> statement-breakpoint
CREATE INDEX `taxonomies_updated_idx` ON `cms_taxonomies` (`_updated_at`);--> statement-breakpoint
CREATE TABLE `cms_users` (
	`_id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`email` text NOT NULL,
	`role` text DEFAULT 'editor',
	`password` text,
	`_created_at` text NOT NULL,
	`_updated_at` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `cms_users_email_unique` ON `cms_users` (`email`);--> statement-breakpoint
CREATE INDEX `users_updated_idx` ON `cms_users` (`_updated_at`);