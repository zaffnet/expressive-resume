#!/usr/bin/env bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo $ROOT_DIR
SRC_DIR="${ROOT_DIR}/src"

build_with_local() {

  echo "Cleaning previous builds..."
  (cd "${SRC_DIR}" && latexmk -f -C -xelatex resume.tex && cd ..)

  echo "Building the resume with local latexmk..."
  (cd "${SRC_DIR}" && latexmk -f -xelatex resume.tex && cd ..)
}

build_with_docker() {
  echo "Building the resume using Docker..."
  local uid gid
  uid="$(id -u 2>/dev/null || echo 0)"
  gid="$(id -g 2>/dev/null || echo 0)"

  echo "Cleaning previous builds..."
  docker build -t resume-builder .
  
  docker run --rm \
    --user "${uid}:${gid}" \
    -v "${SRC_DIR}":/data \
    resume-builder -f -C -xelatex resume.tex

  echo "Building the resume with Docker..."
  docker run --rm \
    --user "${uid}:${gid}" \
    -v "${SRC_DIR}":/data \
    resume-builder -f -xelatex resume.tex

}



if command -v docker >/dev/null 2>&1; then
  build_with_docker
else
  echo "Error: neither latexmk nor Docker is available." >&2
  exit 1
fi

echo $ROOT_DIR