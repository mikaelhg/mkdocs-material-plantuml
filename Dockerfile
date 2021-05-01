ARG PLANTUML_VERSION=1.2021.4
ARG MKDOCS_MATERIAL_VERSION=7.1.0

FROM adoptopenjdk/openjdk16:alpine AS BUILD
ARG PLANTUML_VERSION=1.2021.4
ENV PLANTUML_URL="https://repo1.maven.org/maven2/net/sourceforge/plantuml/plantuml/${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar"
RUN apk add --no-cache wget binutils \
    && wget -q -O /usr/local/lib/plantuml.jar "${PLANTUML_URL}" \
    && /opt/java/openjdk/bin/jlink --no-header-files --no-man-pages --compress=2 --strip-debug \
         --add-modules $(/opt/java/openjdk/bin/jdeps --ignore-missing-deps --print-module-deps /usr/local/lib/plantuml.jar) \
         --output /opt/customjre

FROM squidfunk/mkdocs-material:$MKDOCS_MATERIAL_VERSION
RUN apk add --no-cache fontconfig ttf-dejavu
ADD plantuml /usr/local/bin/plantuml
RUN pip install --no-cache-dir plantuml-markdown
COPY --from=BUILD /opt/customjre /opt/jre
COPY --from=BUILD /usr/local/lib/plantuml.jar /usr/local/lib/plantuml.jar
ENV PATH=/opt/jre/bin:$PATH

CMD [ "build" ]
