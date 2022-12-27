set :haml, :format => :html5

SITE_TITLE = "Shakespeare's Monologues"

# use ConnectionPoolManagement

enable :sessions
set :protection, true
set :protect_from_csrf, false

# TODO Investigate ActiveRecord::QueryCache
# use ActiveRecord::QueryCache

# Configure cache store based on our environment
if ENV["MEMCACHEDCLOUD_SERVERS"]

  # # production
  # register Padrino::Cache
  # enable :caching
  # heroku_dalli_cached = Dalli::Client.new(
  #   ENV["MEMCACHEDCLOUD_SERVERS"].split(','),
  #   :username => ENV["MEMCACHEDCLOUD_USERNAME"],
  #   :password => ENV["MEMCACHEDCLOUD_PASSWORD"])
  #
  # set :cache, Padrino::Cache.new(:Memcached, :backend => heroku_dalli_cached)

  # Force https in production
  unless ENV['RACK_ENV'] == 'development'
    before do
      redirect request.url.sub('http', 'https') unless request.secure?
    end
  end

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

configure do
  set :public_folder, 'static'
  set :views, 'app/views'
end

# get '/' do
#  haml :maintenance, layout: false
# end

get '/' do
   redirect '/home'
end

 get '/home' do
   send_file 'static/home.html'
 end

not_found do
  # haml  :e404, layout: false
  haml :maintenance, layout: false
end

error 500 do
  # haml  :e500, layout: false
  haml :maintenance, layout: false

end

get '/aboutus' do
  content_type 'text/html'
  send_file 'static/aboutus.html'
end

get '/faqs' do
  send_file 'static/faqs.html'
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
