 # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            require 'sinatra'
            require 'rack/protection'
            require 'connection_pool_management'
            require 'sinatra/mailer'
            require 'sinatra/helpers'

            ##
            # Application configuration options
            #
            enable :sessions
            disable :store_location
            set :admin_model, 'Account'
            set :login_page,  '/sessions/new'

            # Access Control
            use Rack::Protection
            use ConnectionPoolManagement
            register Sinatra::Mailer
            register Sinatra::Helpers
            use Rack::Protection::AuthenticityToken

            # Access Control
            access_control = lambda do |role|
              role.protect '/'
              role.allow   '/sessions'
            end

            access_control.call(:any)
            access_control.call(:admin) do |role|
              role.project_module :genders, '/genders'
              role.project_module :monologues, '/monologues'
              role.project_module :plays, '/plays'
              role.project_module :accounts, '/accounts'
            end

            # Custom Error Management
            error(403) { @title = "Error 403"; render('errors/403', :layout => :error) }
            error(404) { @title = "Error 404"; render('errors/404', :layout => :error) }
            error(500) { @title = "Error 500"; render('errors/500', :layout => :error) }