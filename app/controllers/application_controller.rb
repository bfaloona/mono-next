require './config/environment'
require 'sinatra'
require 'haml'
require 'tilt'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    haml :welcome
  end

end
