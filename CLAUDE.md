# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A LaTeX resume/cover letter for Zafarullah Mahmood. The document class hierarchy is `resume.tex` → `ExpressiveResume.cls` → `Expressive.cls` → `article`. Bibliography entries live in `publications.bib` and are rendered with `biblatex`/`biber`.

## Building the PDF

The build requires XeLaTeX (for `fontspec`/OpenType fonts) and Biber (for bibliography). Two paths:

**Local (if `latexmk` is installed):**
```bash
./setup.sh
```

**Docker (fallback):**
```bash
./setup.sh   # auto-detects and uses Docker if latexmk is absent
```

`setup.sh` auto-selects local vs Docker. The Docker path builds the `resume-builder` image from the `Dockerfile` (based on `thubo/latexmk`) which installs EB Garamond and TeX Gyre Math fonts into the TeX Live tree.

The core compile command (used by CI and AGENTS.md) is:
```bash
latexmk -xelatex resume.tex
```

Output: `resume.pdf` in the repo root.

## CI/CD

GitHub Actions workflow (`.github/workflows/build-pdf.yml`) runs on pushes to `main` and PRs. It builds the PDF via Docker, uploads to Cloudflare R2, and posts a comment with the PDF link on PRs. Pushes to `main` also update the canonical URL.

## Architecture

- **`Expressive.cls`** — Base class: defines section/subsection formatting, custom commands (`\achievement`, `\achievementSkill`, `\role`, `\project`, `\tech`, `\mooc`), contact info commands (`\email`, `\phone`, `\github`, `\linkedin`, `\kaggle`, `\webpage`, `\location`), color scheme, hyperlink setup, and list styling. Uses `keycommand` for named arguments.
- **`ExpressiveResume.cls`** — Resume-specific subclass: loads `Expressive`, sets page geometry (14in × 20in), and defines `\resumeheader` (a key-value command for the name/contact block with optional QR code overlay).
- **`resume.tex`** — The actual resume content. Sets fonts (EB Garamond via absolute TeX Live paths), configures `biblatex` with custom author bolding and a custom `inproceedings` driver, and uses the commands from the class files.
- **`publications.bib`** — BibTeX entries for publications, cited from `resume.tex`.
- **`latexmkrc`** — Perl config for latexmk: adds glossary custom dependencies and cleanup extensions.

## Key Details

- Font paths in `resume.tex` are hardcoded to `/usr/local/texlive/2025/...` — the Dockerfile ensures these paths exist regardless of the host TeX Live version.
- The `\tech{}` command renders text in semibold brown (used for technologies/skills).
- The `\role` command uses overlapping `\rlap`/`\makebox` for a three-column layout (title left, company center, dates right).
- Page size is 14in × 20in (not standard letter) — this is intentional for the resume layout.
