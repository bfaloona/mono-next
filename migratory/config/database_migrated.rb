# This file was originally written for Padrino 0.13 by
 # Brandon Faloona, then migrated to Sinatra 3.0.5 by
 # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
 # December 2022.
 #
 
 # Establish configurations for the development and test databases
 configure :development do
   set :database, {
     adapter: 'postgresql',
     database: 'mono_development',
     username: 'brandon',
     password: '',
     host: 'localhost',
     port: 5432
   }
 end
 
 configure :test do
   set :database, {
     adapter: 'postgresql',
     database: 'mono_test',
     username: 'postgres',
     password: '',
     host: 'localhost',
     port: 5432
   }
 end
 
 # Production configuration for ActiveRecord is created by Heroku automatically using their DATABASE_URL environment variable
 
 # Setup the logger
 set :logger, ActiveRecord::Base.logger
 
 # Configure mass assignment protection
 configure :development do
   set :protection, :except => :json_csrf
 end
 
 # Log the query plan for queries taking more than 0.5 seconds
 configure :development do
   ActiveRecord::Base.logger.level = :warn
   ActiveRecord::Base.auto_explain_threshold_in_seconds = 0.5
 end
 
 # Don't include Active Record class name as root for JSON serialized output
 set :include_root_in_json, false
 
 # Store the full class name (including module namespace) in STI type column
 set :store_full_sti_class, true
 
 # Use ISO 8601 format for JSON serialized times and dates
 set :use_standard_json_time_format, true
 
 # Don't escape HTML entities in JSON
 set :escape_html_entities_in_json, false
 
 # Establish connection with the database
 ActiveRecord::Base.establish_connection(settings.database)
 
 # Set the default timezone to UTC
 ActiveRecord::Base.default_timezone = :utc