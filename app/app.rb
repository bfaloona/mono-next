module Monologues
  class App < Padrino::Application

    SITE_TITLE = "Shakespeare's Monologues"

    use ConnectionPoolManagement
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions
    set :protection, true
    set :protect_from_csrf, false

    # TODO Investigate ActiveRecord::QueryCache
    # use ActiveRecord::QueryCache

    # Configure cache store based on our environment
    if ENV["MEMCACHEDCLOUD_SERVERS"]

      # production
      register Padrino::Cache
      enable :caching

      heroku_dalli_cached = Dalli::Client.new(
          ENV["MEMCACHEDCLOUD_SERVERS"].split(','),
          :username => ENV["MEMCACHEDCLOUD_USERNAME"],
          :password => ENV["MEMCACHEDCLOUD_PASSWORD"])
      
      # DISABLED - 2016Jun29
      # set :cache, Padrino::Cache.new(:Memcached, :backend => heroku_dalli_cached)

    else
      # development / test
      # DISABLED FOR SANITY
      # set :cache, Padrino::Cache.new(:LRUHash)
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
      redirect '/home'
    end

    get '/aboutus' do
      send_file 'static/aboutus.html'
    end

    get '/faqs' do
      send_file 'static/faqs.html'
    end

    get '/home' do
      send_file 'static/home.html'
    end

    get '/links' do
      send_file 'static/links.html'
    end

    get '/privacy' do
      send_file 'static/privacy.html'
    end

    get '/sandbox' do
      send_file 'static/sandbox.html'
    end

    # Generate redirects for urls with g querystring param
    use Rack::Rewrite do
      r301 %r{^/plays/(\d\d?)\?g=3(\?.*)?$}, '/men/plays/$1$2'
      r301 %r{^/plays/(\d\d?)\?g=2(\?.*)?$}, '/women/plays/$1$2'
    end

    ###
    # Generate three case insensitive routes
    # for each entry in play_routes hash.
    # For example:
    #   /asyoulikeit
    #   /men/asyoulikeit
    #   /women/asyoulikeit
    #
    men = Gender.find_by_name('Men')
    women = Gender.find_by_name('Women')

    # key is play route symbol
    # value is play id
    play_routes = {
      # As You Like It
      asyoulikeit: 1,
      # The Comedy of Errors
      errors: 2,
      # Cymbeline
      cymbeline: 3,
      # Love's Labour's Lost
      lll: 4,
      # The Merchant of Venice
      merchant: 5,
      # Much Ado About Nothing
      muchado: 6,
      # Twelfth Night, Or What You Will
      '12thnight': 8,
      # All's Well That Ends Well
      allswell: 9,
      # A Midsummer Night's Dream
      midsummer: 13,
      # Henry IV, Part 1
      henryivi: 19,
      # Antony and Cleopatra
      aandc: 29,
      # Hamlet
      hamlet: 31,
      # Lear
      kinglear: 32,
      # Macbeth
      macbeth: 33,
      # Othello
      othello: 34,
      # Romeo and Juliet
      randj: 35
    }
    play_routes.each do |play_key, play_id|
      play_path = "/#{play_key}"
      get(Regexp.new("#{play_path}", true)) { do_play(play_id)}
      get(Regexp.new("/men#{play_path}", true)) { do_play(play_id, men.id)}
      get(Regexp.new("/women#{play_path}", true)) { do_play(play_id, women.id)}
    end

  end
end
