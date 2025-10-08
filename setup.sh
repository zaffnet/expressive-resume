#!/usr/bin/env bash


set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $ROOT_DIR
SRC_DIR="${ROOT_DIR}"

build_with_local() {

  echo "================ building with local latexmk ======================"
  echo "Cleaning previous builds..."
  (cd "${SRC_DIR}" && latexmk -f -C -xelatex resume.tex && cd ..)

  echo "================ building with local latexmk ======================"
  echo "Building the resume with local latexmk..."
  (cd "${SRC_DIR}" && latexmk -f -xelatex resume.tex && cd ..)

  echo "================ building with local latexmk ======================"
  echo "Cleaning all build files except resume.pdf..."
  (cd "${SRC_DIR}" && latexmk -c -dvi- -ps- -pdf- resume.tex && cd ..)
}

build_with_docker() {
  echo "====================================================="
  echo "Building the resume using Docker..."
  local uid gid
  uid="$(id -u 2>/dev/null || echo 0)"
  gid="$(id -g 2>/dev/null || echo 0)"

  echo "====================================================="
  echo "Cleaning previous builds..."
  docker build -t resume-builder .
  docker run --rm \
    --user "${uid}:${gid}" \
    -v "${SRC_DIR}":/data \
    resume-builder -f -C -xelatex resume.tex

  echo "======================================================"
  echo "Building the resume with Docker..."
  docker run --rm \
    --user "${uid}:${gid}" \
    -v "${SRC_DIR}":/data \
    resume-builder -f -xelatex resume.tex

  echo "======================================================"
  echo "Cleaning all build files except resume.pdf..."
  docker run --rm \
    --user "${uid}:${gid}" \
    -v "${SRC_DIR}":/data \
    resume-builder -f -c -dvi- -ps- -pdf- resume.tex

}


if command -v latexmk >/dev/null 2>&1; then
  echo "latexmk is available. Using local installation."
  build_with_local
else
  if command -v docker >/dev/null 2>&1; then
    echo "latexmk is not available, but Docker is. Using Docker."
    build_with_docker
  fi
  echo "Neither latexmk nor Docker is available." >&2
  exit 1
fi


echo $ROOT_DIR
ls -lh "${SRC_DIR}/resume.pdf"