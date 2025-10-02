#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${ROOT_DIR}/src"

build_with_local() {
  echo "Building the resume with local latexmk..."
  (cd "${SRC_DIR}" && latexmk -xelatex resume.tex)

  echo "Cleaning up auxiliary files..."
  (cd "${SRC_DIR}" && latexmk -c resume.tex)
}

build_with_docker() {
  echo "Building the resume using Docker..."
  docker run --rm -v "${ROOT_DIR}":/data thubo/latexmk -output-directory=src -xelatex src/resume.tex

  echo "Cleaning up auxiliary files..."
  docker run --rm -v "${ROOT_DIR}":/data thubo/latexmk -c -output-directory=src src/resume.tex
}

if command -v latexmk >/dev/null 2>&1; then
  build_with_local
elif command -v docker >/dev/null 2>&1; then
  build_with_docker
else
  echo "Error: neither latexmk nor Docker is available." >&2
  exit 1
fi

echo "Setup complete. The PDF should be generated in the src/ directory as resume.pdf"
