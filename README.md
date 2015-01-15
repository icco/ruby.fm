# Ruby.fmRuby.fmRuby.fmRuby.fm

Podcast hosting for Alex Baldwin, and maybe some other kids.

Lots of ideas are over in [ideas/](https://github.com/simplecasual/namefm/tree/master/ideas).

# Design Doc

## Summary

Make sharing new podcasts super easy.

## Overview

The basic features needed are:

 - Create a show
 - Upload a music file greater than fifteen minutes in length (average size 120MB?).
 - Check metadata
 - Publish

## Detailed Design

 * `/` - Home page
 * `/:showname` - Page for a show
 * `/:showname/:title` - Page for a single episode
 * `/login` - Signup and login page
 * `/about` - Sexy about page
