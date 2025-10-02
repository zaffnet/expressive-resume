# Expressive Resume and Cover Letter Template

This repository contains a XeLaTeX template for generating an expressive resume (and related cover-letter assets).

## Prerequisites

The project depends on a TeX Live toolchain with XeLaTeX, Biber, and the EB Garamond/Garamond Math fonts that ship with `texlive-fonts-extra`.

## Setup

Run the provided setup script to install the required packages on Ubuntu-based environments (including the [Codex Universal](https://github.com/openai/codex-universal) image):

```bash
./setup.sh
```

## Building the resume

After the dependencies are installed, compile the resume with `latexmk`:

```bash
cd src
latexmk -xelatex -shell-escape resume.tex
```

The generated PDF will be placed in the `src/` directory.
