---
name: haazel-brand-analyzer
description: Analyze any domain URL to extract brand elements (colors, typography, imagery, voice) and generate a complete brand guide with design tokens for Tailwind/shadcn projects.
---

# Haazel Brand Analyzer

You analyze websites to extract brand identity elements and generate comprehensive brand guides. Use this skill standalone or as Phase 1-2 of the haazel-build workflow.

## Step 1: Fetch and Analyze the Domain

Given a URL, perform a thorough brand extraction:

### Visual Analysis
1. Use WebFetch to get the page HTML and CSS
2. Take a Chrome screenshot of the homepage for visual reference
3. If possible, screenshot key inner pages (about, services)

### Extract Colors
- Parse CSS for color values (hex, rgb, hsl, oklch)
- Identify: primary brand color, secondary colors, accent colors
- Note: background colors, text colors, border colors
- Check for dark mode variants
- Analyze color relationships (complementary, analogous, triadic)

### Extract Typography
- Identify font families from CSS (`font-family` declarations)
- Note font weights used (light, regular, medium, bold)
- Identify heading vs body font pairings
- Check for Google Fonts or custom fonts
- Note font sizes and scale ratios

### Extract Imagery Style
- Analyze hero images and photos: photographic style, subjects, color grading
- Note: illustration vs photography, light vs dark imagery
- Identify image treatment (rounded corners, shadows, overlays)
- Color temperature (warm, cool, neutral)

### Extract Voice & Tone
- Read headline copy: formal/casual, technical/simple
- Analyze body text: sentence length, vocabulary level
- Note: first person vs third person, active vs passive voice
- Identify brand personality adjectives

### Extract Layout Patterns
- Grid structure (columns, spacing)
- Section patterns (full-width, contained, split)
- Navigation style (sticky, transparent, sidebar)
- CTA placement and style

## Step 2: Generate Brand Guide

From the analysis, produce a structured brand guide:

```
## Brand Analysis: {Domain}

### Identity
- Business Name: ...
- Industry: ...
- Target Audience: ...

### Color Palette
| Role | Color | Hex | Usage |
|------|-------|-----|-------|
| Primary | Deep Blue | #1E40AF | CTAs, links, highlights |
| Secondary | Slate | #475569 | Supporting elements |
| Accent | Amber | #F59E0B | Alerts, badges, accents |
| Background | Near White | #FAFAFA | Page background |
| Foreground | Dark Gray | #1F2937 | Body text |
| Muted | Light Gray | #F3F4F6 | Backgrounds, borders |

### Typography
| Role | Font | Weight | Size |
|------|------|--------|------|
| Display | Space Grotesk | 700 | 48-72px |
| Heading | Inter | 600 | 24-36px |
| Body | Inter | 400 | 16px |
| Accent | JetBrains Mono | 500 | 14px |

### Voice Guidelines
- Tone: [adjectives]
- Personality: [adjectives]
- Banned phrases: [list]
- Writing style: [description]

### Imagery Direction
- Style: [photorealistic/illustration/etc.]
- Subjects: [relevant to industry]
- Lighting: [preferences]
- FAL.ai Prompt Formula: "Shot on {camera}, {lens}, {scene}, {lighting}, {style}"
```

## Step 3: Output brand.config.ts

Convert the brand guide into a `brand.config.ts` file following the BrandConfig interface. This file becomes the single source of truth for the entire project.

If updating an existing project, write directly to the project's `brand.config.ts`. If starting fresh, output the config for the user to place in their project root.

## Tips for Better Analysis

- If the site uses a CSS framework (Bootstrap, Tailwind), note the customization layer
- Check `<meta>` tags for brand description and keywords
- Look at `favicon.ico` and `og:image` for brand assets
- Check social media links for additional brand context
- If the site has a style guide or brand page, prioritize that data
- For competitor analysis, note what to differentiate from, not just copy
