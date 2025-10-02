#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${ROOT_DIR}/src"

build_with_local() {
  echo "Building the resume with local latexmk..."
  if ! (cd "${SRC_DIR}" && latexmk -xelatex resume.tex); then
    return 1
  fi

  if [[ ! -f "${SRC_DIR}/resume.pdf" ]]; then
    echo "Local build did not produce src/resume.pdf" >&2
    return 1
  fi

  echo "Cleaning up auxiliary files..."
  (cd "${SRC_DIR}" && latexmk -c resume.tex)
}

build_with_docker() {
  echo "Building the resume using Docker..."
  local uid gid
  uid="$(id -u 2>/dev/null || echo 0)"
  gid="$(id -g 2>/dev/null || echo 0)"

  docker run --rm \
    --user "${uid}:${gid}" \
    --workdir /data/src \
    -v "${ROOT_DIR}":/data \
    thubo/latexmk -xelatex resume.tex

  if [[ ! -f "${SRC_DIR}/resume.pdf" ]]; then
    echo "Docker build did not produce src/resume.pdf" >&2
    return 1
  fi

  echo "Cleaning up auxiliary files..."
  docker run --rm \
    --user "${uid}:${gid}" \
    --workdir /data/src \
    -v "${ROOT_DIR}":/data \
    thubo/latexmk -c resume.tex
}

if command -v latexmk >/dev/null 2>&1; then
  if build_with_local; then
    echo "Setup complete. The PDF should be generated in the src/ directory as resume.pdf"
    exit 0
  fi

  echo "Local latexmk build failed; attempting Docker fallback..." >&2
fi

if command -v docker >/dev/null 2>&1; then
  build_with_docker
else
  echo "Error: neither latexmk nor Docker is available." >&2
  exit 1
fi

echo "Setup complete. The PDF should be generated in the src/ directory as resume.pdf"
