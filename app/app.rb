module Monologues
  class App < Padrino::Application

    use Rack::Protection
    use ConnectionPoolManagement

    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Cache

    enable :sessions
    enable :caching

    # TODO Investigate ActiveRecord::QueryCache
    # use ActiveRecord::QueryCache

    # Configure cache store based on our environment
    if ENV["MEMCACHEDCLOUD_SERVERS"]

      # production
      heroku_dalli_cached = Dalli::Client.new(
          ENV["MEMCACHEDCLOUD_SERVERS"].split(','),
          :username => ENV["MEMCACHEDCLOUD_USERNAME"],
          :password => ENV["MEMCACHEDCLOUD_PASSWORD"])
      set :cache, Padrino::Cache.new(:Memcached, :backend => heroku_dalli_cached)

    else
      # development / test
      set :cache, Padrino::Cache.new(:LRUHash)
    end


    ##
    # Caching support.
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Padrino::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Memcached, :server => '127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memcached, :backend => memcached_or_dalli_instance)
    # set :cache, Padrino::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Redis, :host => '127.0.0.1', :port => 6379, :db => 0)
    # set :cache, Padrino::Cache.new(:Redis, :backend => redis_instance)
    # set :cache, Padrino::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Mongo, :backend => mongo_client_instance)
    # set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    # :show_exceptions is false in production by default, but having it
    # set to true in development can get in the way of our customer error handling.
    # set :show_exceptions, false

    not_found do
      render  'errors/404', layout: false
    end

    error 500 do
      render  'errors/500', layout: false
    end

    get '/' do
      render :home, layout: false
    end

    get '/home' do
      render :home, layout: false
    end

    get '/men' do
      redirect url :plays, :index
    end

    get '/women' do
      redirect url :plays, :index
    end

  end
end
