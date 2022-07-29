ARG MKDOCS_MATERIAL_VERSION=8.3.9

FROM squidfunk/mkdocs-material:$MKDOCS_MATERIAL_VERSION
RUN apk add --no-cache gcompat libstdc++ fontconfig ttf-dejavu ttf-liberation
ADD plantuml /usr/local/bin/plantuml
RUN wget -q -O /usr/local/bin/plantuml https://github.com/mikaelhg/puni2/releases/download/1.2022.6/plantuml-1.2022.6-glibc-x86_64 \
    && chmod 755 /usr/local/bin/plantuml
RUN pip install --no-cache-dir plantuml-markdown

CMD [ "build" ]
