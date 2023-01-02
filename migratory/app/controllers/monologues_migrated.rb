
            # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            
            require 'sinatra/base'
            require 'active_record'
            require 'json'
            
            DISPLAY_LIMIT = 100
            
            class Monologues < Sinatra::Base
              # Get a specific monologue
              get '/monologues/:id' do
                begin
                  @monologue = Monologue.find(params[:id])
                  @title = "#{@monologue.character}'s \"#{@monologue.first_line}\" in #{@monologue.play.title}"
                  session[:play] = nil
      
                  if request.xhr?
                    return @monologue.body
                  else
                    erb :'monologues/show'
                  end
      
                rescue ActiveRecord::RecordNotFound
                  erb :'errors/404', layout: false
                end
              end
              
              # Search for monologues
              post '/search' do
                params = JSON.parse(request.body.read).symbolize_keys!
                default_params = {query: 'e', gender: 'a', play: 0, toggle: 'collapse'}
                params = default_params.merge(params)
                session[:gender] = params[:gender]
                session[:play] = params[:play].to_i rescue 0
                session[:query] = params[:query]
                session[:toggle] = params[:toggle]
      
                logger.info "Search controller: #{@title}"
                @show_play_title = true
                if session[:play] > 0
                  @play = Play.find(session[:play])
                  found_monologues = @play.monologues.gender(params[:gender]).matching(params[:query])
                else
                  found_monologues = Monologue.gender(params[:gender]).matching(params[:query])
                end
                @monologues = found_monologues.take(DISPLAY_LIMIT)
      
                # Debug ouput, displayed in development env
                @debug_output = <<~DEBUGOUT
                play: #{session[:play]}<br/>
                gender: #{session[:gender]}<br/>
                toggle: #{session[:toggle]}<br/>
                query: #{session[:query]}<br/>
                found: #{found_monologues.count}<br/>
                displayed: #{@monologues.count}
                DEBUGOUT
      
                erb :'monologues/_list', layout: false, locals: {toggle: session[:toggle]}
              end
            end