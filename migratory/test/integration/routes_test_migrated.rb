
            # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            require 'sinatra/base'
            require 'json'
            require './monologues.rb'
            require './plays.rb'
            
            # Configures the application
            class MonologuesApp < Sinatra::Base
              configure do
                set :public_folder, File.dirname(__FILE__) + '/public'
              end
              
              # Loads the test config file
              configure :test do
                require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
              end
              
              # Routes for returning plays
              get '/plays/:id' do
                content_type :json
                play = Play.find(params[:id].to_i)
                play.to_json
              end
              
              # Routes for returning monologues
              get '/monologues/:id' do
                content_type :json
                monologue = Monologue.find(params[:id].to_i)
                monologue.to_json
              end
              
              # Routes for returning monologues filtered by gender
              get '/:gender/plays/:id' do
                content_type :json
                play = Play.find(params[:id].to_i)
                monologues = play.monologues.select { |m| m.gender == params[:gender] }
                play.monologues = monologues
                play.to_json
              end
              
              # Routes for returning monologues filtered by gender and expanded
              get '/:gender/plays/:id' do
                content_type :json
                expand = params[:expand] == '1'
                play = Play.find(params[:id].to_i)
                monologues = play.monologues.select { |m| m.gender == params[:gender] }
                play.monologues = monologues
                play.expand_monologues = expand
                play.to_json
              end
              
              # Routes for returning monologues filtered by play, gender, and query
              post '/search' do
                content_type :json
                data = JSON.parse(request.body.read)
                query = data['query']
                gender = data['gender']
                play_id = data['play']
                play = Play.find(play_id.to_i)
                monologues = play.monologues.select { |m| m.gender == gender && m.text.include?(query) }
                play.monologues = monologues
                play.expand_monologues = true
                play.to_json
              end
              
              # Helper method for counting the number of monologues displayed
              def monologues_displayed(last_response)
                JSON.parse(last_response.body)['monologues'].length
              end
            end