
            # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            
            require 'sinatra'
            require 'rack/test'
            require 'minitest/autorun'
            require 'minitest/pride'
            
            # Set test environment
            set :environment, :test
            set :run, false
            set :raise_errors, true
            set :logging, false
            
            # Initialize test application
            def app
              Sinatra::Application
            end
            
            # Configure test application
            configure do
              set :views, File.join(File.dirname(__FILE__), '..', 'views')
            end
            
            # Test routes
            describe 'Monologues' do

              # Test root redirects to /home
              it 'root redirects to /home' do
                get '/'
                follow_redirect!
                last_response.body.must_include 'Making it easier to find monologues since 1997'
              end
              
              # Test /plays renders plays list
              it '/plays renders plays list' do
                get '/plays'
                last_response.body.must_include 'Comedies'
              end
              
              # Test /monologues renders plays list
              it '/monologues renders plays list' do
                get '/monologues'
                last_response.body.must_include 'Histories'
              end
              
              # Test root renders left column ads
              it 'root renders left column ads' do
                skip 'ads suck during development'
                get '/'
                last_response.body.split('3862062942').count.must_equal 2
              end
              
              # Test root renders right column ads
              it 'root renders right column ads' do
                skip 'ads suck during development'
                get '/'
                last_response.body.split('1016396307').count.must_equal 2
              end
              
              # Test root renders link menus and footers
              it 'root renders link menus and footers' do
                skip 'ads suck during development'
                get '/'
                last_response.body.split('The Women').count.must_equal 3
                last_response.body.split('Chrome App').count.must_equal 2
                last_response.body.split('Contact').count.must_equal 3
              end
              
              # Test homepage renders
              it 'homepage renders' do
                get '/home'
                last_response.body.must_include 'Making it easier to find monologues since 1997'
              end
              
              # Test /invalid_path returns 404
              it ' /invalid_path returns 404' do
                get '/invalid_path'
                assert last_response.not_found?
              end
              
            end