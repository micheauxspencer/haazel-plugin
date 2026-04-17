---
name: haazel-auto-blog
description: Set up Sanity CMS integration and ACE-powered auto-blogging for any website. Creates Sanity project, deploys schemas, configures scheduled task for automated blog posts with FAL.ai images.
---

# Haazel Auto-Blog — Sanity CMS + ACE Auto-Blogging Setup

You set up automated blog content publishing for client websites using Sanity CMS, the ACE (Authority Content Engine) skill, and FAL.ai image generation. Use this standalone or as Phase 6 of haazel-build.

## Prerequisites
- Sanity MCP server connected
- FAL_KEY configured in Claude root config
- Project has `brand.config.ts` with blog configuration filled out
- Template available at: `templates/scheduled-task-blog.md` (in the project directory)

---

## Step 1: Set Up Sanity Project

### Option A: Create New Project
Use Sanity MCP tools:
```
list_organizations → pick organization
create_project → name: "{Client Name} Website", organization: {org_id}
```

### Option B: Use Existing Project
```
list_projects → find the client's project
```

Note the project ID and update `brand.config.ts`:
```typescript
sanity: {
  projectId: "xxxx",
  dataset: "production",
}
```

---

## Step 2: Deploy Schema

Deploy the blog schemas to Sanity using the MCP deploy_schema tool.

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

Deploy all schemas via MCP deploy_schema tool.

---

## Step 3: Create Initial Documents

### Create Author
```
Use Sanity MCP: create_documents_from_json
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
Use Sanity MCP: create_documents_from_json
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

1. Read the template from: `{project_directory}/templates/scheduled-task-blog.md`

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

3. Save the completed SKILL.md to the user's Claude scheduled-tasks directory:
   - **Mac/Linux**: `~/.claude/scheduled-tasks/{CLIENT_SLUG}-daily-blog/SKILL.md`
   - **Windows**: `%USERPROFILE%\.claude\scheduled-tasks\{CLIENT_SLUG}-daily-blog\SKILL.md`

4. Register the scheduled task:
   ```
   Use create_scheduled_task MCP tool
   taskId: "{CLIENT_SLUG}-daily-blog"
   cronExpression: "{brand.blog.schedule}"
   prompt: "Run the {CLIENT_SLUG}-daily-blog task"
   description: "Write authority blog posts for {CLIENT_NAME}"
   ```

---

## Step 5: Verify

1. Create a test blog post manually:
   ```
   Use Sanity MCP: create_documents_from_markdown
   Type: post
   Markdown: "# Test Post\n\nThis is a test post to verify the blog integration."
   ```

2. Publish it:
   ```
   Use Sanity MCP: publish_documents
   ```

3. Check that the post appears on the website's /blog page within 60 seconds (ISR revalidation)

4. Run the scheduled task once manually to verify the full ACE workflow:
   - Article generation
   - Image generation via FAL.ai
   - Publishing to Sanity
   - Appearance on the website

---

## Troubleshooting

- **Posts not appearing**: Check ISR revalidation (should be 60s). Verify NEXT_PUBLIC_SANITY_PROJECT_ID and NEXT_PUBLIC_SANITY_DATASET are set correctly.
- **Image upload failing**: Verify SANITY_API_TOKEN has write permissions and FAL_KEY is valid.
- **Duplicate topics**: The scheduled task template includes a Step 1 that queries existing posts. Ensure the GROQ query matches the document type (`post` or `blogPost`).
- **CORS errors**: Add the deployment domain to Sanity CORS origins using add_cors_origin MCP tool.
