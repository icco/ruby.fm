package main

import (
	"net/http"

	"appengine"
	"appengine/blobstore"
)

// Serves up a file in our blobstore.
func handleServe(w http.ResponseWriter, r *http.Request) {
	blobstore.Send(w, appengine.BlobKey(r.FormValue("blobKey")))
}

// Takes a post upload, writes it to blobstore, and then redirects you to the
// file.
func handleUpload(w http.ResponseWriter, r *http.Request) {
	c := appengine.NewContext(r)
	blobs, _, err := blobstore.ParseUpload(r)
	if err != nil {
		serveError(c, w, err)
		return
	}
	file := blobs["file"]
	if len(file) == 0 {
		c.Errorf("no file uploaded")
		http.Redirect(w, r, "/", http.StatusFound)
		return
	}
	http.Redirect(w, r, "/serve/?blobKey="+string(file[0].BlobKey), http.StatusFound)
}

// Generic error serving. Returns a 500.
func serveError(c appengine.Context, w http.ResponseWriter, err error) {
	c.Errorf("%v", err)
	http.Error(w, "We broke", http.StatusInternalServerError)
}
