<!doctype html>
<!--
  Direction board skeleton — Phase 3 of haazel-build renders 2-3 of these
  (board-a/b/c.html), each a genuinely different art direction. Fill every
  {{PLACEHOLDER}} with that direction's candidate values (these are
  PROPOSALS — tokens.json doesn't exist yet). Keep boards comparable:
  same sections, different souls. Delete comments when rendering.
-->
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Direction {{BOARD_LETTER}} — {{DIRECTION_NAME}}</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family={{FAMILIES_QUERY}}&display=swap" rel="stylesheet" />
<style>
  :root {
    --bg: {{bg}}; --fg: {{fg}}; --primary: {{primary}}; --primary-fg: {{primaryFg}};
    --muted-fg: {{mutedFg}}; --card: {{card}};
    --radius: {{radius}};
    --display: "{{displayFamily}}", {{displayFallback}};
    --heading: "{{headingFamily}}", {{headingFallback}};
    --body: "{{bodyFamily}}", {{bodyFallback}};
    --mono: "{{monoFamily}}", {{monoFallback}};
    --hair: 1px solid color-mix(in oklab, var(--fg) 15%, transparent);
  }
  * { margin: 0; box-sizing: border-box; }
  body { background: var(--bg); color: var(--fg); font-family: var(--body);
    padding: clamp(24px, 5vw, 64px); line-height: 1.6; }
  .wrap { max-width: 960px; margin: 0 auto; }
  .overline { font-family: var(--mono); font-size: 11px; letter-spacing: .25em;
    text-transform: uppercase; color: var(--muted-fg); }
  .rail { border-top: var(--hair); padding-top: 10px; margin: 56px 0 24px;
    display: flex; justify-content: space-between; }
  .board-head { display: flex; justify-content: space-between; align-items: baseline; }
  .board-letter { font-family: var(--display); font-size: clamp(64px, 12vw, 140px);
    line-height: 1; font-weight: 500; }
  .adjectives { display: flex; gap: 10px; }
  .pill { border: var(--hair); border-radius: 999px; padding: 6px 16px;
    font-family: var(--mono); font-size: 11px; letter-spacing: .15em; text-transform: uppercase; }
  .strip { display: flex; height: 96px; border-radius: var(--radius); overflow: hidden; border: var(--hair); }
  .strip div { display: flex; align-items: flex-end; padding: 8px 10px;
    font-family: var(--mono); font-size: 10px; }
  /* Hero sketch */
  .hero { border: var(--hair); border-radius: var(--radius); padding: clamp(28px, 6vw, 72px);
    background: {{HERO_BG — bg or a treatment}}; }
  .hero h2 { font-family: var(--display); font-weight: 500;
    font-size: clamp(44px, 8vw, 104px); line-height: .95; letter-spacing: -0.02em; }
  .hero h2 em { font-family: var(--heading); font-style: italic; color: var(--primary);
    display: inline-block; transform: translateY(.06em) rotate(-2deg); }
  .hero p { max-width: 44ch; margin-top: 20px; color: var(--muted-fg); }
  .hero .cta { display: inline-flex; min-height: 44px; align-items: center;
    margin-top: 28px; padding: 10px 28px; background: var(--primary);
    color: var(--primary-fg); border-radius: var(--radius); font-weight: 500; }
  .type-row { display: grid; grid-template-columns: 120px 1fr; gap: 16px;
    border-bottom: var(--hair); padding: 18px 0; align-items: baseline; }
</style>
</head>
<body>
<div class="wrap">

  <div class="board-head">
    <div>
      <p class="overline">Direction {{BOARD_LETTER}} · {{CLIENT_NAME}}</p>
      <div class="board-letter">{{DIRECTION_NAME}}</div>
    </div>
    <div class="adjectives">
      <span class="pill">{{adj1}}</span><span class="pill">{{adj2}}</span><span class="pill">{{adj3}}</span>
    </div>
  </div>

  <div class="rail"><span class="overline">Palette</span><span class="overline">{{USAGE_RULE_ONE_LINER}}</span></div>
  <div class="strip">
    <!-- REPEAT:COLOR width proportional to usage share -->
    <div style="background: {{hex}}; width: {{share}}%; color: {{labelColor}}">{{name}} {{share}}%</div>
    <!-- /REPEAT -->
  </div>

  <div class="rail"><span class="overline">Type pairing</span><span class="overline">{{PAIRING_ONE_LINER}}</span></div>
  <div class="type-row"><span class="overline">display</span>
    <span style="font-family:var(--display); font-size: clamp(32px,5vw,56px); line-height:1">{{displayFamily}} — {{DISPLAY_SAMPLE}}</span></div>
  <div class="type-row"><span class="overline">heading</span>
    <span style="font-family:var(--heading); font-size: clamp(22px,3vw,32px); font-style: italic">{{headingFamily}} — {{HEADING_SAMPLE}}</span></div>
  <div class="type-row"><span class="overline">body</span>
    <span>{{bodyFamily}} — {{BODY_SAMPLE_SENTENCE}}</span></div>
  <div class="type-row"><span class="overline">mono</span>
    <span class="overline" style="color:var(--fg)">{{monoFamily}} — {{OVERLINE_SAMPLE}}</span></div>

  <div class="rail"><span class="overline">Hero sketch</span><span class="overline">the feeling, not the final</span></div>
  <div class="hero">
    <p class="overline" style="margin-bottom:18px">{{HERO_EYEBROW}}</p>
    <h2>{{HERO_LINE_1}} <em>{{HERO_ITALIC_WORD}}</em><br/>{{HERO_LINE_2}}</h2>
    <p>{{HERO_SUPPORT_SENTENCE}}</p>
    <span class="cta">{{HERO_CTA}}</span>
  </div>

  <div class="rail"><span class="overline">Motion & posture</span><span class="overline">radius {{radius}}</span></div>
  <p style="max-width:58ch">{{MOTION_POLICY_STATEMENT — policy name + the two or three signature moves this direction earns}}</p>

</div>
</body>
</html>
