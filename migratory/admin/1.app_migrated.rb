
            #
            # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            
            # Require necessary gems and set up application
            require 'sinatra'
            require 'rack/protection'
            require 'connection_pool_management'
            require 'sinatra/mailer'
            require 'sinatra/flash'
            require 'sinatra/activerecord'
            require 'sinatra/admin/access_control'
            
            # Define the Monologues application class
            class Monologues < Sinatra::Base
              # Enable session support
              enable :sessions
              
              # Disable storing the last location
              disable :store_location
              
              # Set up protection and connection pooling
              use Rack::Protection
              use ConnectionPoolManagement
              
              # Register Sinatra helpers and mailer
              register Sinatra::Mailer
              register Sinatra::Helpers
              register Sinatra::Admin::AccessControl
              
              # Set application configuration options
              set :raise_errors, true # Raise exceptions (will stop application) (default for test)
              set :dump_errors, true # Exception backtraces are written to STDERR (default for production/development)
              set :show_exceptions, true # Shows a stack trace in browser (default for development)
              set :logging, true # Logging in STDOUT for development and file for production (default only for development)
              set :public_folder, "foo/bar" # Location for static assets (default root/public)
              set :reload, false # Reload application files (default in development)
              set :default_builder, "foo" # Set a custom form builder (default 'StandardFormBuilder')
              set :locale_path, "bar" # Set path for I18n translations (default your_app/locales)
              disable :sessions # Disabled sessions by default (enable if needed)
              disable :flash # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
              set :layout, :my_layout # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
              
              # Set admin model, login page, and access control roles
              set :admin_model, 'Account'
              set :login_page,  '/sessions/new'
              
              # Set up access control for any user
              access_control.roles_for :any do |role|
                role.protect '/'
                role.allow   '/sessions'
              end
              
              # Set up access control for admin user
              access_control.roles_for :admin do |role|
                role.project_module :genders, '/genders'
                role.project_module :monologues, '/monologues'
                role.project_module :plays, '/plays'
                role.project_module :accounts, '/accounts'
              end
              
              # Custom error management 
              error(403) { @title = "Error 403"; render('errors/403', :layout => :error) }
              error(404) { @title = "Error 404"; render('errors/404', :layout => :error) }
              error(500) { @title = "Error 500"; render('errors/500', :layout => :error) }
            end