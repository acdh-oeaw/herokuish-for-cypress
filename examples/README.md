Serving everything using server.js as static file server
========================================================

Copy the `server` directory to the root of your project next to the `dist` directory
that is created when you build for production.

```json
  "scripts": {
     "start": "cd server && npm install --only=production && node server.js"
  }
```

TODO: actions integration

Note taht `NODE_ENV=test` has a special meaning in VUE.
So to use cypress you need to have a `test` command like this:

```json
  "scripts": {
     "test": "NODE_ENV=production vue-cli-service test:e2e --headless --env PORT=8080"
  }
```
