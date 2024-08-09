# Computational Model Extractor using CodeQL/Python

## CodeQL Setup

[Setting up the CodeQL CLI](https://docs.github.com/en/code-security/codeql-cli/getting-started-with-the-codeql-cli/setting-up-the-codeql-cli)

## Initiate/Update CodeQL Database

```sh
./update-db.sh
```

## Run Query

```sh
codeql query run --database=db queries/example.ql
```
