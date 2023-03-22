ARG MKDOCS_MATERIAL_VERSION=9.1.3
ARG PLANTUML_VERSION=1.2023.4

FROM squidfunk/mkdocs-material:$MKDOCS_MATERIAL_VERSION
ARG PLANTUML_VERSION
RUN apk add --no-cache gcompat libstdc++ fontconfig ttf-dejavu ttf-liberation graphviz
RUN wget -q -O /usr/local/bin/plantuml https://github.com/mikaelhg/puni2/releases/download/${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}-glibc-x86_64 \
    && chmod 755 /usr/local/bin/plantuml
RUN pip install --no-cache-dir plantuml-markdown

CMD [ "build" ]
