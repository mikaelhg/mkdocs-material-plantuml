FROM squidfunk/mkdocs-material:latest
ARG PLANTUML_VERSION=1.2020.15
ADD plantuml /usr/local/bin/plantuml
RUN apk add --no-cache openjdk11 wget \
    && pip install --no-cache-dir plantuml-markdown \
    && wget -q -O /usr/local/lib/plantuml.jar \
           "https://repo1.maven.org/maven2/net/sourceforge/plantuml/plantuml/${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar" \
    && rm -rf /tmp/*

# https://github.com/AdoptOpenJDK/openjdk-docker/issues/75
RUN apk add --no-cache fontconfig ttf-dejavu
RUN ln -s /usr/lib/libfontconfig.so.1 /usr/lib/libfontconfig.so && \
    ln -s /lib/libuuid.so.1 /usr/lib/libuuid.so.1 && \
    ln -s /lib/libc.musl-x86_64.so.1 /usr/lib/libc.musl-x86_64.so.1
ENV LD_LIBRARY_PATH /usr/lib

CMD [ "build" ]
