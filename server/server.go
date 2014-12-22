// Contains the entry point for all web requests.
package main

import (
	"html/template"
	"net/http"

	// Blobstore hasn't been ported to new App Engine API yet, so we can't use
	// the fancy https://github.com/golang/appengine/ import paths yet (which is
	// so lame).
	"appengine"

	"github.com/gorilla/mux"
	"github.com/simplecasual/namefm/handlers"
)

var rootTemplate = template.Must(template.New("root").Parse(rootTemplateHTML))

const rootTemplateHTML = `
<html>
<head>
<title>Name.FM</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<form action="{{.}}" method="POST" enctype="multipart/form-data">
Upload File: <input type="file" name="file"><br>
<input type="submit" name="submit" value="Submit">
</form>
</body>
</html>
`

func handleRoot(w http.ResponseWriter, r *http.Request) {
	c := appengine.NewContext(r)
	uploadURL, err := blobstore.UploadURL(c, "/upload", nil)
	if err != nil {
		serveError(c, w, err)
		return
	}
	w.Header().Set("Content-Type", "text/html")
	err = rootTemplate.Execute(w, uploadURL)
	if err != nil {
		c.Errorf("%v", err)
	}
}

func init() {
	r := mux.NewRouter()
	r.HandleFunc("/", handleRoot)
	r.HandleFunc("/js", http.FileServer(http.Dir("public/js")))
	r.HandleFunc("/css", http.FileServer(http.Dir("public/css")))
	r.HandleFunc("/serve/", handlers.handleServe).Methods("GET")
	r.HandleFunc("/upload", handlers.handleUpload).Methods("POST")
	r.HandleFunc("/settings", handlers.SettingsGetHandler).Methods("GET")
	r.HandleFunc("/settings", handlers.SettingsPostHandler).Methods("POST")

	http.Handle("/", r)
}
