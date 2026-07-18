---
name: haazel-auto-blog
description: Set up Sanity CMS integration and ACE-powered auto-blogging for any website. Creates Sanity project, deploys schemas, configures scheduled task for automated blog posts with FAL.ai images.
---

# Haazel Auto-Blog — Sanity CMS + ACE Auto-Blogging Setup

You set up automated blog content publishing for client websites using
Sanity CMS, the ACE (Authority Content Engine) skill, and FAL.ai image
generation. Use this standalone or as Phase 10 of haazel-build.

## Prerequisites

- **Sanity MCP** — connector-level; detected at Step 1, guided manual setup
  if absent.
- **scheduled-tasks MCP** — connector-level; detected at Step 1, falls back
  to "write the file, tell the user to register it" if absent (Step 4).
- **FAL_KEY** — in env or the project's `.env.local`, for blog header images.
- Project has `brand.config.ts` with blog configuration filled out.
- Template: this plugin's `templates/scheduled-task-blog.md` — the plugin
  ships its own copy so this skill never depends on the target project
  still having one.

---

## Step 1: Detect Connectors, Then Set Up Sanity Project

**Detect first, silently:**
- Sanity MCP — ToolSearch for `list_organizations` / `create_project`.
- scheduled-tasks MCP — ToolSearch for `create_scheduled_task`. Not needed
  until Step 4, but check now so it isn't a surprise mid-setup.

**Sanity absent:** guide manual setup — the user creates a project at
sanity.io/manage (or runs `npx sanity init` in the target project) and
gives you back the project ID and dataset name. Connecting the Sanity
connector and re-running is the better path when that's an option; either
way, carry the project ID/dataset forward into the steps below.

**Sanity present:**

### Option A: Create New Project
```
list_organizations → pick organization
create_project → name: "{Client Name} Website", organization: {org_id}
create_dataset → projectId: {from create_project}, name: "production"
```

### Option B: Use Existing Project
```
list_projects → find the client's project
query_documents → check for existing post/author/category docs before
                   assuming this is a green field
```

Note the project ID and dataset name, then update `brand.config.ts`:
```typescript
sanity: {
  projectId: "xxxx",
  dataset: "production",
}
```

---

## Step 2: Deploy Schema

Deploy the blog schemas to Sanity using the MCP `deploy_schema` tool.

### Required Schemas:

**Post Schema:**
```javascript
{
  name: 'post',
  type: 'document',
  fields: [
    { name: 'title', type: 'string', validation: (Rule) => Rule.required() },
    { name: 'slug', type: 'slug', options: { source: 'title' } },
    { name: 'excerpt', type: 'text', rows: 3 },
    { name: 'tldr', type: 'text', rows: 3 },
    { name: 'keyTakeaways', type: 'array', of: [{ type: 'string' }] },
    { name: 'body', type: 'array', of: [{ type: 'block' }, { type: 'image' }] },
    { name: 'faq', type: 'array', of: [{ type: 'object', fields: [
      { name: 'question', type: 'string' },
      { name: 'answer', type: 'text' }
    ]}]},
    { name: 'mainImage', type: 'image', options: { hotspot: true }, fields: [
      { name: 'alt', type: 'string' }
    ]},
    { name: 'categories', type: 'array', of: [{ type: 'reference', to: [{ type: 'category' }] }] },
    { name: 'author', type: 'reference', to: [{ type: 'author' }] },
    { name: 'publishedAt', type: 'datetime' },
    { name: 'readingTime', type: 'string' },
    { name: 'seoTitle', type: 'string' },
    { name: 'seoDescription', type: 'text' },
    { name: 'primaryKeyword', type: 'string' },
    { name: 'secondaryKeywords', type: 'array', of: [{ type: 'string' }] },
    { name: 'tags', type: 'array', of: [{ type: 'string' }] },
  ]
}
```

**Author Schema:**
```javascript
{
  name: 'author',
  type: 'document',
  fields: [
    { name: 'name', type: 'string', validation: (Rule) => Rule.required() },
    { name: 'slug', type: 'slug', options: { source: 'name' } },
    { name: 'bio', type: 'text' },
    { name: 'credentials', type: 'string' },
    { name: 'image', type: 'image' },
  ]
}
```

**Category Schema:**
```javascript
{
  name: 'category',
  type: 'document',
  fields: [
    { name: 'title', type: 'string', validation: (Rule) => Rule.required() },
    { name: 'slug', type: 'slug', options: { source: 'title' } },
    { name: 'description', type: 'text' },
  ]
}
```

Deploy all schemas via the MCP `deploy_schema` tool, then call `get_schema`
to confirm the deploy landed and to read back the exact field names before
writing any documents — Sanity MCP's own guidance is to always load the
schema before reading or writing.

---

## Step 3: Create Initial Documents

### Create Author
```
Use Sanity MCP: create_documents
Type: author
Content: {
  name: "{brand.blog.authorName}",
  bio: "{brand.blog.authorBio}",
  credentials: "{brand.blog.authorCredentials}",
  slug: { _type: "slug", current: "{slugified-author-name}" }
}
```
Note the author document ID for the scheduled task.

### Create Categories
Create a category document for each item in `brand.blog.topicCategories`.

### Create Site Settings
```
Use Sanity MCP: create_documents
Type: siteSettings
Content: {
  title: "{brand.client.name}",
  description: "{brand.client.description}"
}
```

### Add CORS Origin
```
Use Sanity MCP: add_cors_origin
Origin: http://localhost:3000 (for development)
Also add the production domain when deploying
```

---

## Step 4: Configure Auto-Blog Scheduled Task

1. Read the template from **this plugin's** `templates/scheduled-task-blog.md`
   (not the target project — the plugin owns the canonical copy).

2. Replace all placeholders with values from `brand.config.ts`:

| Placeholder | Source |
|-------------|--------|
| {CLIENT_NAME} | brand.client.name |
| {CLIENT_SLUG} | brand.client.slug |
| {NICHE} | brand.blog.niche |
| {TARGET_AUDIENCE} | brand.blog.targetAudience |
| {REGION} | brand.blog.region |
| {AUTHOR_NAME} | brand.blog.authorName |
| {AUTHOR_CREDENTIALS} | brand.blog.authorCredentials |
| {VOICE_RULES} | brand.blog.voiceRules |
| {SANITY_PROJECT_ID} | brand.sanity.projectId |
| {SANITY_DATASET} | brand.sanity.dataset |
| {TOPIC_CATEGORIES} | brand.blog.topicCategories (formatted as list) |
| {CTA_TEXT} | brand.blog.ctaText |
| {CTA_URL} | brand.blog.ctaUrl |
| {INTERNAL_PAGES} | brand.blog.internalPages (formatted as list) |
| {WORKING_DIRECTORY} | Project directory path |
| {BLOG_SCHEDULE} | brand.blog.schedule (cron expression) |
| {IMAGE_CAMERAS} | brand.imagery.cameras |
| {IMAGE_LENSES} | brand.imagery.lenses |
| {IMAGE_SUBJECTS} | brand.imagery.subjects |
| {IMAGE_LIGHTING} | brand.imagery.lighting |
| {IMAGE_AVOID} | brand.imagery.avoidKeywords |

3. Save the completed file to the user's Claude scheduled-tasks directory:
   - **Mac/Linux**: `~/.claude/scheduled-tasks/{CLIENT_SLUG}-daily-blog/SKILL.md`
   - **Windows**: `%USERPROFILE%\.claude\scheduled-tasks\{CLIENT_SLUG}-daily-blog\SKILL.md`

4. Register it:
   - **scheduled-tasks MCP detected:** call `create_scheduled_task` —
     `taskId: "{CLIENT_SLUG}-daily-blog"`, `cronExpression: "{brand.blog.schedule}"`,
     `prompt: "Run the {CLIENT_SLUG}-daily-blog task"`,
     `description: "Write authority blog posts for {CLIENT_NAME}"`.
   - **Absent:** the file is already on disk from step 3 — tell the user
     exactly where, and that they need to register it from a claude.ai
     session (scheduled tasks aren't manageable from this connector-less
     session). Don't block the rest of the setup on this.

---

## Step 5: Verify

1. Create a test blog post manually:
   ```
   Use Sanity MCP: create_documents
   Type: post
   Content: { title: "Test Post", body: [ /* Portable Text blocks */ ],
              slug: { _type: "slug", current: "test-post" }, ... }
   ```
   (`create_documents` takes structured fields — `body` is Portable Text
   blocks, not a raw markdown string.)

2. Publish it:
   ```
   Use Sanity MCP: publish_documents
   ```

3. Check that the post appears on the website's /blog page within 60 seconds (ISR revalidation)

4. Run the scheduled task once manually to verify the full ACE workflow (or,
   if the connector was absent, ask the user to trigger it once they've
   registered it from claude.ai):
   - Article generation
   - Image generation via FAL.ai
   - Publishing to Sanity
   - Appearance on the website

---

## Troubleshooting

- **Posts not appearing**: Check ISR revalidation (should be 60s). Verify NEXT_PUBLIC_SANITY_PROJECT_ID and NEXT_PUBLIC_SANITY_DATASET are set correctly.
- **Image upload failing**: Verify SANITY_API_TOKEN has write permissions and FAL_KEY is valid.
- **Duplicate topics**: The scheduled task template includes a Step 1 that queries existing posts. Ensure the GROQ query matches the document type (`post` or `blogPost`).
- **CORS errors**: Add the deployment domain to Sanity CORS origins using the `add_cors_origin` MCP tool.
- **Sanity tool call fails with "not found"**: you're likely using a stale
  tool name. The verified surface is `list_organizations`, `create_project`,
  `create_dataset`, `deploy_schema`, `add_cors_origin`, `create_documents`,
  `patch_documents`, `publish_documents`, `query_documents`, `get_schema` —
  there is no `create_documents_from_json`, `create_documents_from_markdown`,
  or `patch_document_from_json`.
- **Scheduled task never fires**: the scheduled-tasks connector wasn't
  available when this was set up. Confirm the user actually registered the
  written task file from a claude.ai session.
