
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#
require 'sinatra'

# Generates a fully-qualified URL from a given path
def full_url(path)
  'http://' + PROD_WEBSITE + path
end

# Prepends the protocol to a given URL
def prepend_protocol(url)
  return url.match(/^https?\:\/\//) ? url : 'http://' + url
end

# Counts the number of monologues displayed in a given response
def monologues_displayed(response)
  response.body.downcase.split('firstline').count - 1
end