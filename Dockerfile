FROM ghcr.io/openai/codex-universal:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        latexmk \
        texlive-xetex \
        texlive-latex-extra \
        texlive-fonts-extra \
        texlive-bibtex-extra \
        biber \
        fontconfig && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN chmod +x ./setup.sh && ./setup.sh

WORKDIR /app/src

CMD ["latexmk", "-xelatex", "resume.tex"]
