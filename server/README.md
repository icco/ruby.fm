# server

Basically this is a very simple Go server that does three things:

 1. Serve static html, css and javascript. (This will be removed in the future).
 2. Act as a simple REST+JSON server for CRUD operations.
 3. Proxy uploads to Google's blobstore.

## Deploy

 * Install `gcloud`: https://cloud.google.com/sdk/gcloud/
 * `gcloud preview app deploy . --project=inawordfm`
 * Or use `make deploy` from one directory up.

## Run locally

 * `gcloud preview app run . --project=inawordfm`
 * Or use `make run` from one directory up.
