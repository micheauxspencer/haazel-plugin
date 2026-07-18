<!doctype html>
<!--
  DESIGN_SYSTEM.html skeleton — the visual spec the user approves.
  The haazel-design-system skill inlines REAL values from tokens.json:
  replace every {{PLACEHOLDER}}, duplicate blocks marked REPEAT, delete
  these comments. Keep it self-contained (Google Fonts <link> allowed).
-->
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>{{CLIENT_NAME}} — Design System</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<!-- {{FONTS_LINK: one <link> loading display/heading/body/mono families with the exact weights/styles/axes from tokens}} -->
<link href="https://fonts.googleapis.com/css2?family={{FAMILIES_QUERY}}&display=swap" rel="stylesheet" />
<style>
  :root {
    /* {{VAR_BLOCK: every semantic color as hex, plus:}} */
    --background: {{bg}}; --foreground: {{fg}}; --card: {{card}};
    --card-foreground: {{cardFg}}; --primary: {{primary}};
    --primary-foreground: {{primaryFg}}; --secondary: {{secondary}};
    --muted: {{muted}}; --muted-foreground: {{mutedFg}};
    --accent: {{accent}}; --accent-foreground: {{accentFg}};
    --border: {{border}}; --destructive: {{destructive}};
    --radius: {{radius}};
    --font-display: "{{displayFamily}}", {{displayFallback}};
    --font-heading: "{{headingFamily}}", {{headingFallback}};
    --font-body: "{{bodyFamily}}", {{bodyFallback}};
    --font-mono: "{{monoFamily}}", {{monoFallback}};
    --ease: {{easeStandard}};
    --hairline: 1px solid color-mix(in oklab, var(--foreground) 14%, transparent);
  }
  * { margin: 0; box-sizing: border-box; }
  body {
    background: var(--background); color: var(--foreground);
    font-family: var(--font-body); line-height: 1.6;
    padding: clamp(24px, 5vw, 72px);
  }
  .wrap { max-width: 1080px; margin: 0 auto; }
  .overline {
    font-family: var(--font-mono); font-size: 11px; letter-spacing: .25em;
    text-transform: uppercase; color: var(--muted-foreground);
  }
  .rail { border-top: var(--hairline); padding-top: 10px; display: flex;
    justify-content: space-between; align-items: baseline; margin: 72px 0 32px; }
  h1 { font-family: var(--font-display); font-weight: 500;
    font-size: clamp(40px, 7vw, 88px); line-height: .95; letter-spacing: -0.02em; }
  h1 em { font-family: var(--font-heading); font-style: italic; color: var(--primary); }
  .grid { display: grid; gap: 16px; }
  .swatches { grid-template-columns: repeat(auto-fill, minmax(160px, 1fr)); }
  .swatch { border: var(--hairline); border-radius: var(--radius); overflow: hidden; }
  .swatch .chip { height: 84px; }
  .swatch .info { padding: 10px 12px; font-family: var(--font-mono); font-size: 11px; }
  .swatch .info b { display: block; font-family: var(--font-body); font-size: 13px; margin-bottom: 2px; }
  .pair { display: flex; align-items: center; justify-content: space-between;
    border-radius: var(--radius); padding: 14px 18px; border: var(--hairline); }
  .pair .ratio { font-family: var(--font-mono); font-size: 11px; }
  .ok { color: var(--primary); } .bad { color: var(--destructive); }
  .specimen { border: var(--hairline); border-radius: var(--radius); padding: 28px; margin-bottom: 16px; }
  .specimen .meta { font-family: var(--font-mono); font-size: 11px;
    color: var(--muted-foreground); margin-bottom: 12px; letter-spacing: .1em; }
  .bar { height: 10px; background: color-mix(in oklab, var(--primary) 30%, transparent);
    border-left: 2px solid var(--primary); margin: 6px 0; }
  .chips { display: flex; flex-wrap: wrap; gap: 10px; }
  .chip-pill { border: var(--hairline); border-radius: 999px; padding: 6px 14px;
    font-family: var(--font-mono); font-size: 11px; letter-spacing: .1em; text-transform: uppercase; }
  .banned { text-decoration: line-through; color: var(--muted-foreground); }
  .btn { display: inline-flex; align-items: center; min-height: 44px; padding: 10px 26px;
    border-radius: var(--radius); font-weight: 500; font-size: 15px; cursor: pointer;
    transition: transform .3s var(--ease); border: none; font-family: var(--font-body); }
  .btn:hover { transform: translateY(-2px); }
  .btn.primary { background: var(--primary); color: var(--primary-foreground); }
  .btn.outline { background: transparent; color: var(--foreground);
    border: 1px solid color-mix(in oklab, var(--foreground) 18%, transparent); }
  .card-demo { background: var(--card); color: var(--card-foreground);
    border: var(--hairline); border-radius: var(--radius); padding: 24px; max-width: 380px; }
  table { width: 100%; border-collapse: collapse; font-size: 14px; }
  td, th { text-align: left; padding: 10px 12px; border-bottom: var(--hairline); }
  th { font-family: var(--font-mono); font-size: 11px; letter-spacing: .15em;
    text-transform: uppercase; color: var(--muted-foreground); font-weight: 500; }
  .mono { font-family: var(--font-mono); }
</style>
</head>
<body>
<div class="wrap">

  <p class="overline">Haazel design system · {{ARCHETYPE}} · {{COLOR_SCHEME}} · {{DATE}}</p>
  <h1 style="margin-top:16px">{{CLIENT_NAME}}<br/><em>{{SIGNATURE_WORD}}</em> {{HEADLINE_REST}}</h1>
  <p style="max-width:56ch; margin-top:24px; color: var(--muted-foreground)">{{POSITIONING_PARAGRAPH}}</p>

  <div class="rail"><span class="overline">01 — Palette</span><span class="overline">{{PALETTE_RULE_SHORT}}</span></div>
  <div class="grid swatches">
    <!-- REPEAT:SWATCH for every palette + key semantic color -->
    <div class="swatch">
      <div class="chip" style="background: {{hex}}"></div>
      <div class="info"><b>{{name}}</b>{{hex}} · {{share}}%<br/><span style="color:var(--muted-foreground)">{{role}}</span></div>
    </div>
    <!-- /REPEAT -->
  </div>
  <div class="grid" style="grid-template-columns: repeat(auto-fill, minmax(240px,1fr)); margin-top:16px">
    <!-- REPEAT:PAIR for body/muted/primary-button/card contrast pairs -->
    <div class="pair" style="background: {{pairBg}}; color: {{pairFg}}">
      <span>{{pairLabel}}</span><span class="ratio {{okOrBad}}">{{ratio}}:1</span>
    </div>
    <!-- /REPEAT -->
  </div>

  <div class="rail"><span class="overline">02 — Typography</span><span class="overline">{{PAIRING_SUMMARY}}</span></div>
  <div class="specimen">
    <div class="meta">display · {{displayFamily}} {{displayWeight}} · {{heroSize}}</div>
    <div style="font-family:var(--font-display); font-size: clamp(48px,8vw,110px); line-height:.95; letter-spacing:-.02em; font-weight:500">{{DISPLAY_SPECIMEN_LINE}}</div>
  </div>
  <div class="specimen">
    <div class="meta">heading · {{headingFamily}} · italic overlay move</div>
    <div style="font-family:var(--font-heading); font-size: clamp(28px,4vw,52px); line-height:1.05">{{HEADING_SPECIMEN}} <em style="color:var(--primary)">{{ITALIC_WORD}}</em></div>
  </div>
  <div class="specimen">
    <div class="meta">body · {{bodyFamily}} · overline · {{monoFamily}}</div>
    <p style="max-width:60ch">{{BODY_SPECIMEN_PARAGRAPH}}</p>
    <p class="overline" style="margin-top:14px">{{OVERLINE_SPECIMEN}}</p>
  </div>
  <table>
    <tr><th>Role</th><th>Size</th><th>Line</th><th>Face</th><th>Notes</th></tr>
    <!-- REPEAT:SCALE row per scale entry -->
    <tr><td class="mono">{{role}}</td><td class="mono">{{size}}</td><td class="mono">{{lh}}</td><td>{{face}}</td><td>{{notes}}</td></tr>
    <!-- /REPEAT -->
  </table>

  <div class="rail"><span class="overline">03 — Space & shape</span><span class="overline">radius {{radius}} · container {{containerMax}}</span></div>
  <div class="mono" style="font-size:11px; color:var(--muted-foreground)">section {{sectionGap}}</div>
  <div class="bar" style="width: 88%"></div>
  <div class="mono" style="font-size:11px; color:var(--muted-foreground)">content {{contentGap}}</div>
  <div class="bar" style="width: 44%"></div>
  <div class="mono" style="font-size:11px; color:var(--muted-foreground)">element {{elementGap}}</div>
  <div class="bar" style="width: 14%"></div>

  <div class="rail"><span class="overline">04 — Components</span><span class="overline">specimens</span></div>
  <div style="display:flex; gap:16px; flex-wrap:wrap; align-items:flex-start">
    <button class="btn primary">{{PRIMARY_CTA_LABEL}}</button>
    <button class="btn outline">{{SECONDARY_CTA_LABEL}}</button>
    <div class="card-demo">
      <p class="overline" style="margin-bottom:10px">{{CARD_OVERLINE}}</p>
      <p style="font-family:var(--font-heading); font-size:20px; margin-bottom:8px">{{CARD_TITLE}}</p>
      <p style="font-size:14px; color:var(--muted-foreground)">{{CARD_BODY}}</p>
    </div>
  </div>

  <div class="rail"><span class="overline">05 — Motion</span><span class="overline">policy: {{MOTION_POLICY}}</span></div>
  <p style="max-width:60ch">{{MOTION_POLICY_STATEMENT}}</p>
  <div class="chips" style="margin-top:14px">
    <span class="chip-pill">ease {{easeStandard}}</span>
    <span class="chip-pill">base {{durationBase}}</span>
    <span class="chip-pill">reveal {{durationReveal}}</span>
    <!-- REPEAT:BANNED --><span class="chip-pill banned">{{bannedModule}}</span><!-- /REPEAT -->
  </div>

  <div class="rail"><span class="overline">06 — Voice & imagery</span><span class="overline">{{IMAGERY_STYLE}}</span></div>
  <div class="chips">
    <!-- REPEAT:TONE --><span class="chip-pill">{{tone}}</span><!-- /REPEAT -->
    <!-- REPEAT:BANNEDPHRASE --><span class="chip-pill banned">{{phrase}}</span><!-- /REPEAT -->
  </div>
  <p class="mono" style="font-size:12px; margin-top:16px; color:var(--muted-foreground)">{{IMAGE_FORMULA}}</p>

  <p class="overline" style="margin-top:96px; border-top: var(--hairline); padding-top: 12px">
    generated by haazel {{VERSION}} · source design/tokens.json · apply: npm run tokens:apply
  </p>
</div>
</body>
</html>
