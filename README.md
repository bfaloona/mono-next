[![Build Status](https://travis-ci.org/bfaloona/mono-next.svg?branch=master)](https://travis-ci.org/bfaloona/mono-next)

Monologues Next
===============

Synopsis
--------

Prototype of updated Shakespeare's Monologues site

Development
----------

### Prerequisites
   - git, heroku toolbelt
   - ruby 2.2.1, bundler
   - postgres

### Setup
 - See (project wiki)[https://github.com/bfaloona/mono-next/wiki]

### Workflow
 - `bundle` to configure
 - `bundle exec rake` to test
 - `heroku local web` to run
 - make changes / run tests
 - `git push origin master` (or push to a branch)
 - travis ci runs:  [![Build Status](https://travis-ci.org/bfaloona/mono-next.svg?branch=master)](https://travis-ci.org/bfaloona/mono-next)
 - [staging site](https://mono-next.herokuapp.com/) auto-deploys if build passes
 



.