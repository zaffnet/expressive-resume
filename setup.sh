#!/bin/bash
#
# Setup script for the expressive-resume repository.
# This script is designed to be run in a Debian-based environment
# (like Ubuntu 24.04 or the openai/codex-universal Docker image)
# to install all necessary dependencies for compiling the LaTeX resume.

# --- Exit on Error ---
set -e

# --- 1. Update Package Manager ---
echo "Updating package lists..."
sudo apt-get update -y

# --- 2. Install TeX Live and Biber ---
# We need a modern TeX distribution with specific packages.
# - texlive-latex-base: Core LaTeX packages.
# - texlive-latex-extra: Includes titlesec, xcolor, and other required packages.
# - texlive-fonts-extra: Required for fontawesome5 icons.
# - texlive-publishers: Often contains bibliography styles like IEEE.
# - texlive-luatex: Required for the lualatex engine, needed for fontspec.
# - biber: The backend for processing the bibliography as specified in resume.tex.
# - latexmk: A tool to automate the build process.
echo "Installing TeX Live, Biber, and Latexmk..."
sudo apt-get install -y \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-publishers \
    texlive-luatex \
    texlive-xetex \
    biber \
    latexmk

# --- 3. Install Required System Fonts ---
# The resume uses the EB Garamond font, which needs to be installed system-wide
# for fontspec to find it.
echo "Installing EB Garamond font..."
sudo apt-get install -y fonts-ebgaramond

# --- 3a. Update Font Cache ---
# After installing new fonts, it's crucial to update the system's font cache.
# This allows applications like XeLaTeX (via fontspec) to find and use them.
echo "Updating font cache..."
sudo fc-cache -fv

# --- 4. Build the Resume ---
# The final step is to compile the resume.tex file into a PDF using XeLaTeX.
# We use latexmk with the -xelatex flag because the .tex file uses the
# fontspec package, which requires either LuaLaTeX or XeLaTeX.
# latexmk will automatically run biber and xelatex the correct
# number of times to resolve all references and citations.
echo "Building the resume..."
cd src
latexmk -xelatex resume.tex
latexmk -c # Clean up auxiliary files
cd ..
# --- Done ---
echo "Setup complete. The PDF should be generated in the src/ directory as resume.pdf"
