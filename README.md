# PlantUML support for mkdocs-material

```bash
docker build -t mikaelhg/mkdocs-material-plantuml .
```

## Build locally

```bash
docker run --rm -it -v ${PWD}:/docs mikaelhg/mkdocs-material-plantuml
```

## Github Actions

```yaml
    - name: mkdocs build
      uses: "docker://mikaelhg/mkdocs-material-plantuml:latest"
```
