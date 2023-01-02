
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

# Configure Sinatra settings
configure do
  enable :sessions
  set :session_secret, '56e1c3a632f04f93dcb9c9d2b013e8f8996e7529ebe38f046dc7cbda185b5f86'
  set :protection, :except => :path_traversal
  set :protect_from_csrf, :except => ["/api/monologues"]
end

# Mounts the applications for this project

# Mount Monologues::Admin sub-application
use Rack::Session::Cookie, :key => '_monologues_admin_session',
                           :path => '/admin',
                           :secret => '56e1c3a632f04f93dcb9c9d2b013e8f8996e7529ebe38f046dc7cbda185b5f86'
use Monologues::Admin

# Mount Monologues::App sub-application
use Rack::Session::Cookie, :key => '_monologues_app_session',
                           :path => '/',
                           :secret => '56e1c3a632f04f93dcb9c9d2b013e8f8996e7529ebe38f046dc7cbda185b5f86'
use Monologues::App