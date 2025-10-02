#!/usr/bin/env bash
set -euo pipefail

# Determine whether sudo is required.
if [[ "${EUID}" -ne 0 ]]; then
  SUDO="sudo"
else
  SUDO=""
fi

# Refresh package metadata and install dependencies needed to build the LaTeX resume.
${SUDO} apt-get update
${SUDO} apt-get install -y \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-fonts-extra \
  texlive-bibtex-extra \
  texlive-xetex \
  latexmk \
  biber

# Print instructions for compiling the resume once dependencies are installed.
cat <<'EOM'
LaTeX toolchain installed.
To compile the resume, run:
  cd src
  latexmk -xelatex -shell-escape resume.tex
EOM
