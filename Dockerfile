FROM thubo/latexmk:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        texlive-fonts-recommended \
        texlive-fonts-extra \
        texlive-latex-extra && \
    rm -rf /var/lib/apt/lists/*


RUN groupadd -g 1000 latex && useradd -u 1000 -g latex latex
USER latex

ADD latexmkrc /home/latex/.latexmkrc

WORKDIR /data
ENTRYPOINT ["latexmk"]
CMD ["-help"]