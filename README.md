A container for gitlab CI/CD test stage with cypress.io dependencies
======================================================================

The default herokuish container lacks the X11 and other dependencies the headless electron browser of cypress.io e2e testing needs. This repo contains an add on Dockerfile that adds these dependencies as well as some example config files that are needed to make this work

Better e2e tests than none at all!

Usage
-----

In our gl-autodevops-minimal-port the test step accepts a `herokuish_base_image` as a parameter. Specify `ghcr.io/acdh-oeaw/herokuish-for-cypress/main there`

Best practice: Add version information for node and npm to your package JSON. E.g.:

```json
,
  "engines": {
    "node": "20.x",
    "npm": "6.14.x"
  }
```

You also need to make sure you serve your app using some static web server. An example server you can use can be found in the examples directory.

You need to have scripts for `start` and `test` defined in your package.json. E. g. for vue with `@vue/cli-plugin-e2e-cypress` installed:

```json
  "scripts": {
    [...]
    "start": "node server.js",
    "test": "NODE_ENV=production vue-cli-service test:e2e --headless --env PORT=8080"
  }
```

_Note_: The `test` environment has a special meaning for vue (unit tests) and so for end to end tests you have to set the environment explicitly. The implicit NODE_ENV would be `test`.

Probably set the project CI variable

```bash
POSTGRES_ENABLED=false
```

You will rarely need a Postgres DB so don't prepare it.

Local testing
-------------

To make sure your tests run in the AutoDevOps pipline you can test the test stage locally using your own docker instance like this

```bash
docker run --rm -v $(pwd):/tmp/app ghcr.io/acdh-oeaw/herokuish-for-cypress/main /bin/herokuish buildpack test
```
