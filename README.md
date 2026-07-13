# Handoff: ITB.guru Rebuild — Industrial Technology Bridge

## Overview
Complete redesign of itb.guru, refocusing the brand from generic IT/computer sales to **Quality Engineering × Applied AI × Industry 4.0** consulting for Alexander Feht (ASQ-CQE, 12+ years QE). ITB is renamed "Industrial Technology Bridge." One-page marketing site with a dark, industrial-technical, spec-sheet aesthetic.

The deployment target is a **Docker container** (static site + nginx) portable between a local machine and a VPS, with dynamic DNS for the itb.guru domain. See "Deployment" below.

## About the Design Files
`ITB Site.dc.html` is a **design reference created in HTML** — a prototype showing the intended look and behavior. Since this is a fully static one-page site, the pragmatic implementation is to **recreate it as a plain static site** (single `index.html` + assets, or a minimal static-site generator like Astro/Eleventy if a blog is added later). Do NOT ship the .dc.html file directly — it depends on a proprietary runtime (`support.js`). Recreate the markup with the inline styles converted to a small stylesheet.

## Fidelity
**High-fidelity.** Colors, typography, spacing, and copy are final. Recreate pixel-perfectly. Only intended changes: real GitHub links are already in place; the availability badge date ("Q3 2026") should be easy to edit.

## Design Tokens
- Background (page): `#0E0F0D`
- Background (alt sections / cards): `#121310`
- Background (footer): `#0B0C0A`
- Hairline borders / grid lines: `#26271F`
- Secondary borders (chips, outline buttons): `#3B3C33`
- Text primary: `#ECEAE4`
- Text secondary: `#B9B7AB`
- Text muted / mono labels: `#8A897E`
- Text faint: `#4E4F45`
- Accent (amber): `#E8A33D`; hover: `#F2C170`
- Selection: amber background, dark text
- Fonts: **Archivo** (400–900) for display/body; **IBM Plex Mono** (400–600) for labels, chips, metadata. Google Fonts.
- No border radius anywhere (sharp, industrial). No shadows. 1px hairlines are the primary structural device — the 1200px content column has 1px left/right borders running the full page height.
- Links: default `#E8A33D`, hover `#F2C170`.

## Layout System
- Content column: `max-width: 1200px`, centered, `border-left/right: 1px solid #26271F`, horizontal padding 32px.
- Sections separated by 1px `#26271F` rules; alternating backgrounds `#0E0F0D` / `#121310`.
- Card grids use `gap: 1px; background: #26271F; border: 1px solid #26271F` with `#121310`/`#0E0F0D` cells — hairline-grid effect.
- Sticky header: 64px, `rgba(14,15,13,0.92)` + `backdrop-filter: blur(8px)`.

## Screens / Sections (single page, top to bottom)

### 1. Nav (sticky)
"ITB" wordmark (Archivo 900, 22px) + "INDUSTRIAL TECHNOLOGY BRIDGE" (Plex Mono 11px, `#8A897E`, letter-spacing 1px). Right: anchor links Services / Track record / Lab / Writing (14px, `#B9B7AB`, hover `#ECEAE4`) + amber "Book a call" button (13px/700, dark text, 9px×18px padding).

### 2. Hero
- Availability badge: Plex Mono 12px amber, 1px `#3A3626` border, pulsing 7px amber dot (2s opacity keyframe). Text: "AVAILABLE FOR ENGAGEMENTS — Q3 2026".
- Kicker: "QUALITY ENGINEERING × APPLIED AI × INDUSTRY 4.0" (Plex Mono 13px `#8A897E`).
- H1: "Quality systems built for the AI-era factory." — Archivo 900, `clamp(42px, 6.5vw, 80px)`, line-height 1.02, letter-spacing −2px, max-width 920px.
- Sub (19px `#B9B7AB`, max 640px): "Twelve-plus years of hands-on quality engineering — automotive, mechatronics, electronics fabrication, heavy equipment — now paired with data science, local LLMs, and the infrastructure engineering to run them on the shop floor. Proven systems first. New technology where it earns its place."
- CTAs: amber filled "Book a discovery call" (15px/700, 15px×30px padding) + outlined "See what I do" (border `#3B3C33`, hover border amber).
- Bottom-right corner detail (Plex Mono 11px `#4E4F45`, right-aligned): "ITB.GURU / EST. 2019 / REV 3.0 — REFOCUSED 2026".
- Section padding: 96px top, 88px bottom.

### 3. Industry strip
Full-width band (`#121310`) of five equal cells split by hairlines, Plex Mono 12px `#8A897E`, centered: AUTOMOTIVE · MECHATRONICS · ELECTRONICS FAB · HEAVY EQUIPMENT · MACHINE VISION.

### 4. Services (`#services`)
Kicker "/ WHAT I DO" (Plex Mono 13px amber) + H2 "Three ways in. One standard of rigor." (Archivo 800, 40px). Three cards in hairline grid (`repeat(auto-fit, minmax(300px, 1fr))`), each: amber mono number (01/02/03), H3 22px/700, body 15px `#B9B7AB` line-height 1.65, then chip row (Plex Mono 11px, `#8A897E`, 1px `#3B3C33` border, 4px×8px padding, flex gap 8px):

1. **Quality Engineering, done right** — "The core discipline: supplier & vendor quality, NPI launches, root-cause investigation, QMS design and audits, continuous improvement. Twelve years across regulated, high-stakes manufacturing." Chips: SUPPLIER QUALITY, NPI, ROOT CAUSE, QMS / AUDIT.
2. **AI-augmented quality workflows** — "Practical AI where it pays for itself: RAG systems over your technical documentation, local LLMs for audit prep and reporting, faster data analysis. Runs on-prem — your process data never leaves the building." Chips: RAG / LOCAL LLM, FMEA / 8D, DATA ANALYSIS, AUTOMATION.
3. **Industry 4.0 readiness** — "Getting quality data out of binders and into systems: digitalized inspection records, dashboards, vision-inspection pilots, additive manufacturing feasibility. Scoped pilots before big bets." Chips: DIGITALIZATION, DASHBOARDS, VISION PILOTS, ADDITIVE MFG.

### 5. Track record (`#record`, alt background)
Two-column grid (minmax 320px, gap 64px). Left: kicker "/ TRACK RECORD", H2 "Alexander Feht" (36px/800), two paragraphs (16px `#B9B7AB` lh 1.7) — see file for exact copy (Senior Vendor QE Specialist, machine-vision manufacturer, metal AM feasibility R&D, mixed-reality training, RAG/local-LLM tooling, ASQ-CQE, UofT DSI AI/ML). Right: 2×2 hairline stat grid on `#0E0F0D` cells:
- "12+" (Archivo 900 40px amber) / YEARS IN QUALITY ENGINEERING
- "6" / INDUSTRIES SERVED
- "ASQ-CQE" (18px/700 white) / + UOFT DSI AI/ML CERTIFICATE
- "NPI → EOL" / FULL LIFECYCLE COVERAGE
Stat captions: Plex Mono 11px `#8A897E`, letter-spacing 1px.

### 6. Lab (`#lab`)
Kicker "/ THE LAB", H2 "Working experiments, in the open.", intro para with inline link to https://github.com/ALEX8642. Three linked cards (grid minmax 300px, gap 20px, `#121310`, 1px `#26271F` border, hover border amber, padding 28px). Each card: mono path label (`github://…`, amber 12px) + status tag (POC or TOOL — Plex Mono 10px/600, amber bg, dark text, 3px×8px) in a space-between row; title 18px/700; body 14px `#8A897E`.
1. `github://wafer-defect-classifier` [POC] → https://github.com/ALEX8642/wafer-defect-classifier — "ResNet-18 on WM-811K wafer maps — focal loss, CBAM attention, Grad-CAM++ explainability. Macro-F1 0.916 across 9 defect classes. Extended with SimCLR self-supervised pretraining on 638k unlabeled maps (wafer-ssl)."
2. `github://audio2report` [TOOL] → https://github.com/ALEX8642/audio2report — "Turns dual-microphone meeting recordings into clean, deduplicated transcripts and LLM-generated audit reports. Fully local — no data leaves the building."
3. `github://LLM-chatbot` [TOOL] → https://github.com/ALEX8642/LLM-chatbot — "Retrieval-augmented chatbot over technical documentation, built on Haystack 2.x and Ollama. Ask the manual instead of digging through it — runs entirely on local models."

### 7. Writing (`#writing`, alt background)
Kicker "/ WRITING", H2 "Notes from the field." List of three post rows (title 18px/600 left, date Plex Mono 12px `#8A897E` right, space-between, 24px vertical padding, hairline bottom border, hover text amber). Links currently point at the old WordPress URLs — replace with migrated post URLs when the blog is ported.

### 8. Contact (`#contact`)
Centered, 104px vertical padding. Kicker "/ CONTACT", H2 "Got a quality problem technology should be solving?" (Archivo 900, clamp 32–56px), sub "Thirty minutes, no pitch. We look at your process, and I tell you honestly what's worth automating — and what isn't." CTAs: amber `mailto:alexander@itb.guru` button + outlined LinkedIn button → https://www.linkedin.com/in/afeht/.

### 9. Footer
`#0B0C0A`, Plex Mono 12px `#4E4F45`, space-between: "© 2026 ITB.GURU — INDUSTRIAL TECHNOLOGY BRIDGE" / "WATERLOO REGION, ONTARIO · REMOTE-FRIENDLY".

## Interactions & Behavior
- All nav/CTA anchors smooth-scroll to section ids (`#services`, `#record`, `#lab`, `#writing`, `#contact`).
- Hover states: links lighten (`#B9B7AB`→`#ECEAE4`), amber buttons lighten to `#F2C170`, outlined buttons/cards get amber border, writing rows turn amber.
- Availability dot: `@keyframes pulse-dot { 0%,100% { opacity:1 } 50% { opacity:.3 } }`, 2s infinite.
- The prototype has three toggles (availability badge, Lab section, Writing section) — implement as simple build-time config/flags, not runtime UI.
- Responsive: grids use `auto-fit/minmax` so they collapse naturally; header nav will need a mobile treatment (not designed — a simple wrap or hamburger is fine; ask before inventing anything elaborate).

## State Management
None. Fully static content.

## Assets
No images. Two Google Font families (Archivo, IBM Plex Mono) — consider self-hosting the woff2 files in the container for zero external dependencies.

## Files
- `ITB Site.dc.html` — the full design reference (all copy, exact inline styles).

## Deployment (requested architecture)
Static site in Docker, portable local ⇄ VPS, dynamic DNS for itb.guru:

```
site/                  # static build output (index.html, css, fonts)
Dockerfile             # FROM nginx:alpine; COPY site/ /usr/share/nginx/html
docker-compose.yml     # web (nginx, port 80/443) + ddns sidecar
```

- **Web**: `nginx:alpine` serving the static files; add gzip + cache headers. If TLS terminates in-container, use a `caddy` image instead of nginx for automatic Let's Encrypt.
- **Dynamic DNS**: `qmcgaw/ddns-updater` sidecar (or a cron hitting the Cloudflare API) keeping the itb.guru A record pointed at the current IP. If the domain moves to Cloudflare DNS (recommended), proxied mode also gives free TLS and hides the home IP.
- **Portability**: single `docker compose up -d` on either local hardware or any VPS; no volumes needed beyond ddns config.
- Old WordPress URLs for the three blog posts should get 301 redirects if the posts are migrated to new paths.
