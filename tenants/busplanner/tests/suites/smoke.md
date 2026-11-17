---
name: smoke
description: Is the environment up and serving the build we think it is? Read-only. Run before any other suite.
env: us-staging
tag: [smoke]
---
# Suite: smoke

Read-only health checks of one environment: API health, the build the app reports, and the signed-in app shell. Runs in a few minutes. Run it first on any environment before a longer suite; if it is not green, the other results are not trustworthy.
