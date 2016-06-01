# Ruby.fm

Podcast hosting for Alex Baldwin, and maybe some other kids.

Lots of ideas are over in [ideas/](https://github.com/simplecasual/namefm/tree/master/ideas).

## Profit sharing

| Person        | Percentage           |
| ------------- |:-------------:|
| Matthew Johnston | 50%      |
| Alex Baldwin     | 50%      |

## Setup

 * The following environment variables need to be set: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `S3_BUCKET`, `S3_REGION`
 * If you put them in a file, you can call the following to start a local rails server with those variables:
```
 $ env `cat iam.env` rails s
```

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
 * `/upload` - Upload a new file
 * `/:showname` - Page for a show
 * `/:showname/:title` - Page for a single episode
 * `/login` - Signup and login page
 * `/about` - Sexy about page

# Deployment

We currently deploy on heroku. If you need a system dependency that you know for
a fact is apart of the debian apt repo, then feel free to add it to the
`Aptfile`. Just understand that for every dependency you add, it will increase
the slug size.
