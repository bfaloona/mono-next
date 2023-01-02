
#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Sinatra,
# just execute it from the command line.

# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

require 'sinatra'
require 'sinatra/reloader'

# Require the boot file which will require all other files
require File.expand_path("../config/boot.rb", __FILE__)

# Run the Sinatra application
run Sinatra::Application