
            #
 # This file was originally written for Padrino 0.13 by
 # Brandon Faloona, then migrated to Sinatra 3.0.5 by
 # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
 # December 2022.
 #

require 'sinatra'
require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'sinatra/cookies'
require 'sinatra/flash'
require 'sinatra/json'
require 'sinatra/session'
require 'sinatra/streaming'
require 'sinatra/param'
require 'connection_pool_management'
require 'dalli'
require 'redis'
require 'mongo'

# Module Monologues
module Monologues
  class App < Sinatra::Base

    # Site title
    SITE_TITLE = "Shakespeare's Monologues"

    # Use ConnectionPoolManagement
    use ConnectionPoolManagement

    # Register Sinatra::Mailer
    register Sinatra::Mailer

    # Register Sinatra::Helpers
    register Sinatra::Helpers

    # Enable sessions
    enable :sessions

    # Set protection
    set :protection, true

    # Set protect_from_csrf
    set :protect_from_csrf, false

    # Configure cache store based on environment
    if ENV["MEMCACHEDCLOUD_SERVERS"]

      # Production
      register Sinatra::Cache
      enable :caching

      # Create Dalli Client
      heroku_dalli_cached = Dalli::Client.new(
        ENV["MEMCACHEDCLOUD_SERVERS"].split(','),
        username: ENV["MEMCACHEDCLOUD_USERNAME"],
        password: ENV["MEMCACHEDCLOUD_PASSWORD"]
      )

      # Set cache
      set :cache, Sinatra::Cache.new(:Memcached, backend: heroku_dalli_cached)

      # Force HTTPS in production
      unless RACK_ENV == 'development'
        before do
          redirect request.url.sub('http', 'https') unless request.secure?
        end
      end

    else

      # Development / Test
      # DISABLED FOR SANITY
      # set :cache, Sinatra::Cache.new(:LRUHash)
    end

    # Caching support
    # You can customize caching store engines
    # set :cache, Sinatra::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Sinatra::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Sinatra::Cache.new(:Memcached, server: '127.0.0.1:11211', exception_retry_limit: 1)
    # set :cache, Sinatra::Cache.new(:Memcached, backend: memcached_or_dalli_instance)
    # set :cache, Sinatra::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Sinatra::Cache.new(:Redis, host: '127.0.0.1', port: 6379, db: 0)
    # set :cache, Sinatra::Cache.new(:Redis, backend: redis_instance)
    # set :cache, Sinatra::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Sinatra::Cache.new(:Mongo, backend: mongo_client_instance)
    # set :cache, Sinatra::Cache.new(:File, dir: Sinatra.root('tmp', app_name.to_s, 'cache')) # default choice

    # Application configuration options
    # set :raise_errors, true # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true # Shows a stack trace in browser (default for development)
    # set :logging, true # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false # Reload application files (default in development)
    # set :default_builder, 'foo' # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar' # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions # Disabled sessions by default (enable if needed)
    # disable :flash # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout :my_layout # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)

    # You can configure for a specified environment like
    # configure :development do
    #   set :foo, :bar
    #   disable :asset_stamp # no asset timestamping for dev
    # end

    # Set show_exceptions to false in production by default, but having it
    # set to true in development can get in the way of our customer error handling.
    set :show_exceptions, false

    # Not found route
    not_found do
      render 'errors/404', layout: false
    end

    # Error 500 route
    error 500 do
      render 'errors/500', layout: false
    end

    # Redirect to home route
    get '/' do
      redirect '/home'
    end

    # About us route
    get '/aboutus' do
      send_file 'static/aboutus.html'
    end

    # FAQs route
    get '/faqs' do
      send_file 'static/faqs.html'
    end

    # Home route
    get '/home' do
      send_file 'static/home.html'
    end

    # Links route
    get '/links' do
      send_file 'static/links.html'
    end

    # Privacy route
    get '/privacy' do
      send_file 'static/privacy.html'
    end

    # Sandbox route
    get '/sandbox' do
      send_file 'static/sandbox.html'
    end
  end
end