FROM ubuntu:20.04
ARG PLANTUML_VERSION=1.2020.15
ADD plantuml /usr/local/bin/plantuml
ADD requirements.txt /tmp/requirements.txt
RUN apt-get -qq update \
    && apt-get -qqy install openjdk-14-jdk-headless python3-pip wget \
    && wget -q -O /usr/local/lib/plantuml.jar \
            "https://repo1.maven.org/maven2/net/sourceforge/plantuml/plantuml/${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar" \
    && pip3 install -r /tmp/requirements.txt \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /docs
ENTRYPOINT [ "mkdocs" ]
CMD [ "build" ]
