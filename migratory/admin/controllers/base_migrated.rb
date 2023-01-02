
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

require 'sinatra/base'

class Monologues::Admin < Sinatra::Base
  get '/' do
    # This section of code renders the 'base/index' view
    render "base/index"
  end
end