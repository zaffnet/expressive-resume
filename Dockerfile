FROM thubo/latexmk:latest

USER root

RUN set -eux; \
    for year in 2025 2024 2023 2022; do \
        if [ -d "/usr/local/texlive/${year}/texmf-dist/fonts/opentype/public/ebgaramond" ]; then \
            src_year="$year"; \
            break; \
        fi; \
    done; \
    if [ -z "${src_year:-}" ]; then \
        echo "EB Garamond directory not found in TeX Live tree" >&2; \
        exit 1; \
    fi; \
    src_root="/usr/local/texlive/${src_year}/texmf-dist/fonts/opentype/public"; \
    dest_root="/usr/local/texlive/2025/texmf-dist/fonts/opentype/public"; \
    mkdir -p "$dest_root"; \
    for family in ebgaramond tex-gyre-math; do \
        if [ ! -d "${src_root}/${family}" ]; then \
            echo "Missing font family ${family} in source tree" >&2; \
            exit 1; \
        fi; \
        rm -rf "${dest_root:?}/${family}"; \
        cp -a "${src_root}/${family}" "$dest_root"; \
    done; \
    mktexlsr


USER latex

ADD latexmkrc /home/latex/.latexmkrc

WORKDIR /data
ENTRYPOINT ["latexmk"]
CMD ["-help"]
