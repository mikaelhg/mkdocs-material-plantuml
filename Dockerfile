FROM adoptopenjdk:15-hotspot-bionic AS build
ARG PLANTUML_VERSION=1.2021.0
ENV PLANTUML_URL="https://repo1.maven.org/maven2/net/sourceforge/plantuml/plantuml/${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar"
RUN apt-get -qq update \
    && apt-get -qqy install wget binutils \
    && wget -q -O /usr/local/lib/plantuml.jar "${PLANTUML_URL}" \
    && jlink --no-header-files --no-man-pages --compress=2 --strip-debug \
         --add-modules $(jdeps --ignore-missing-deps --print-module-deps /usr/local/lib/plantuml.jar) \
         --output /opt/customjre

FROM ubuntu:20.04
ARG PLANTUML_VERSION=1.2021.0
ADD plantuml /usr/local/bin/plantuml
ADD requirements.txt /tmp/requirements.txt
COPY --from=build /opt/customjre /opt/customjre
COPY --from=build /usr/local/lib/plantuml.jar /usr/local/lib/plantuml.jar
RUN apt-get -qq update \
    && apt-get -qqy install fontconfig fonts-ubuntu python3-pip \
    && pip3 install -r /tmp/requirements.txt \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /docs
ENTRYPOINT [ "mkdocs" ]
CMD [ "build" ]
