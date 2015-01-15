# Name.FM

Podcast hosting for Alex Baldwin, and maybe some other kids.

Lots of ideas are over in [ideas/](https://github.com/simplecasual/namefm/tree/master/ideas).

# Design Doc

## Summary

Make sharing new podcasts super easy.

## Overview

The basic features needed are:

 - Upload a music file greater than fifteen minutes in length (average size 120MB?).
 - Attach that file to a user
 - Sign in with twitter
 - Create a playlist containing works by 1 - N Users

## Detailed Design

 * `/` - Home page
 * `/:showname` - Page for a show
 * `/:showname/:title` - Page for a single episode
 * `/login` - Signup and login page
 * `/about` - Sexy about page
