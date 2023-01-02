
            # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            require 'sinatra'
            require 'sinatra/cache'
            require 'sinatra/reloader'
            require 'sinatra/namespace'
            require 'sinatra/cookies'
            require 'sinatra/flash'
            require 'sinatra/session'
            require 'sinatra/redirect_with_flash'
            require 'sinatra/content_for'
            require 'sinatra/asset_pipeline'
            require 'sinatra/json'
            require 'sinatra/contrib'
            require 'sinatra/partial'
            require 'sinatra/activerecord'

            # Define the play routes hash
            # key: play route symbol
            # value: play id
            # comment: title
            play_routes = {
              as_you_like_it: 1, # As You Like It
              alls_well_that_ends_well: 2, # All's Well That Ends Well
              antony_and_cleopatra: 3, # Antony and Cleopatra
              coriolanus: 4, # Coriolanus
              cymbeline: 5, # Cymbeline
              hamlet: 6, # Hamlet
              henry_iv_part_1: 7, # Henry IV, Part 1
              henry_iv_part_2: 8, # Henry IV, Part 2
              henry_v: 9, # Henry V
              henry_vi_part_1: 10, # Henry VI, Part 1
              henry_vi_part_2: 11, # Henry VI, Part 2
              henry_vi_part_3: 12, # Henry VI, Part 3
              henry_viii: 13, # Henry VIII
              julius_caesar: 14, # Julius Caesar
              king_john: 15, # King John
              king_lear: 16, # King Lear
              love_labours_lost: 17, # Love's Labour's Lost
              macbeth: 18, # Macbeth
              measure_for_measure: 19, # Measure for Measure
              merchant_of_venice: 20, # The Merchant of Venice
              merry_wives_of_windsor: 21, # The Merry Wives of Windsor
              midsummer_nights_dream: 22, # A Midsummer Night's Dream
              much_ado_about_nothing: 23, # Much Ado About Nothing
              othello: 24, # Othello
              pericles: 25, # Pericles
              richard_ii: 26, # Richard II
              richard_iii: 27, # Richard III
              romeo_and_juliet: 28, # Romeo and Juliet
              taming_of_the_shrew: 29, # The Taming of the Shrew
              tempest: 30, # The Tempest
              timon_of_athens: 31, # Timon of Athens
              titus_andronicus: 32, # Titus Andronicus
              troilus_and_cressida: 33, # Troilus and Cressida
              twelfth_night: 34, # Twelfth Night
              two_gentlemen_of_verona: 35, # The Two Gentlemen of Verona
              winters_tale: 36 # The Winter's Tale
            }

            # Define the gender_word method
            # which takes a gender letter
            # and returns the gender word
            def gender_word(gender_letter)
              gender_letter == 'm' ? 'Male' : 'Female'
            end

            # Define the gender_letter method
            # which takes a gender word
            # and returns the gender letter
            def gender_letter(gender_word)
              gender_word == 'Male' ? 'm' : 'f'
            end

            # Define the gender_from_path method
            # which takes a request path
            # and returns the gender letter
            def gender_from_path
              case request.path
              when '/men'
                'm'
              when '/women'
                'f'
              else
                nil
              end
            end

            # Set up Sinatra ActiveRecord
            configure :development do
              set :database, {adapter: 'sqlite3', database: 'db/monologues.sqlite3'}
            end

            # Set up Sinatra Assets
            register Sinatra::AssetPipeline

            # Set up Sinatra Cache
            configure do
              set :cache_enabled, true
              set :cache_timeout, 60
            end

            # Set up Sinatra Contrib
            register Sinatra::Contrib

            # Define the Play model
            class Play < ActiveRecord::Base
              has_many :monologues
            end

            # Define the Monologue model
            class Monologue < ActiveRecord::Base
              belongs_to :play
            end

            # Route to the play index
            #
            # This route gets the gender from the path
            # and sets the gender and title in the session
            # and renders the index page
            play_index = lambda do
              session[:gender] = gender_from_path || gender_letter(params[:g]) || 'a'
              @title = "#{gender_word(session[:gender])} Monologues in Shakespeare"
              @plays = Play.all
              @comedies = Play.where(classification: 'Comedy')
              @histories = Play.where(classification: 'History')
              @tragedies = Play.where(classification: 'Tragedy')
              @scope = "#{gender_word(session[:gender])}"
              session[:play] = nil
              render 'plays/index'
            end

            # Route to index page with cache enabled
            get :index, map: '/plays', cache: true, &play_index

            # Route to monologues page with cache enabled
            get :monologues, map: '/monologues', cache: true, &play_index

            # Route to men page with cache enabled
            get :men, map: '/men', cache: true, &play_index

            # Route to women page with cache enabled
            get :women, map: '/women', cache: true, &play_index

            # Route to monologues index page
            #
            # This route gets the play from the params
            # and sets the play, gender and title in the session
            # and renders the monologues index page
            monologues_index = lambda do
              @play = Play.find(params[:id].to_i)
              session[:play] = @play.id
              session[:gender] = gender_from_path || gender_letter(params[:g]) || 'a'
              @title = "#{gender_word(session[:gender])} Monologues in #{@play.title}"
              @monologues = @play.monologues.gender(session[:gender])
              session[:toggle] = (params[:expand] == '1') ? 'expand' : 'collapse'

              # Debug ouput, displayed in development env
              @debug_output = <<~DEBUGOUT
              play: #{session[:play]}<br/>
              gender: #{session[:gender]}<br/>
              toggle: #{session[:toggle]}<br/>
              title: #{@title}<br/>
              query: #{session[:query]}<br/>
              found: #{@monologues.count}<br/>
              displayed: #{@monologues.count}
              DEBUGOUT

              render 'monologues/index', locals: {toggle: session[:toggle]}
            end

            # Route to show page with cache enabled
            get :show, map: "/plays/:id", cache: true, &monologues_index

            # Route to showwomen page with cache enabled
            get :showwomen, map: "/women/plays/:id", cache: true, &monologues_index

            # Route to showmen page with cache enabled
            get :showmen, map: "/men/plays/:id", cache: true, &monologues_index

            # Generate three case insensitive routes
            # for each entry in play_routes hash.
            # For example:
            #   /asyoulikeit
            #   /men/asyoulikeit
            #   /women/asyoulikeit
            play_routes.each do |route, id|
              # Route to play index page with cache enabled
              get route, map: "/#{route.to_s.gsub('_', '')}", cache: true, &play_index

              # Route to men play index page with cache enabled
              get :"#{route}_men", map: "/men/#{route.to_s.gsub('_', '')}", cache: true, &play_index

              # Route to women play index page with cache enabled
              get :"#{route}_women", map: "/women/#{route.to_s.gsub('_', '')}", cache: true, &play_index
            end
            # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            # This file contains a hash of plays and the corresponding ids, and routes to handle requests for those plays. 
            play_routes = {
              asyoulikeit:    1,  # As You Like It
              coe:         2,  # The Comedy of Errors
              cymbeline:      3,  # Cymbeline
              lll:            4,  # Love's Labour's Lost
              merchant:       5,  # The Merchant of Venice
              muchado:        6,  # Much Ado About Nothing
              shrew:          7,  # The Taming of the Shrew
              '12thnight':    8,  # Twelfth Night, Or What You Will
              allswell:       9,  # All's Well That Ends Well
              measure:       10,  # Measure for Measure
              merrywives:    11,  # Merry Wives of Windsor
              merchent:      12,  # Merchant of Venice
              midsummer:     13,  # A Midsummer Night's Dream
              tempest:       14,  # The Tempest
              troilus:       15,  # Troilus and Cressida
              twogents:      16,  # Two Gentlemen of Verona
              winterstale:   17,  # The Winter's Tale
              pericles:      18,  # Pericles Prince of Tyre
              'henryiv-i':   19,  # Henry IV, Part 1
              'henryiv-ii':  20,  # Henry IV, Part 2
              henryv:        21,  # Henry V
              'henryvi-i':   22,  # Henry VI, Part 1
              'henryvi-ii':  23,  # Henry VI, Part 2
              'henryvi-iii': 24,  # Henry VI, Part 3
              henryviii:     25,  # Henry VIII
              kingjohn:      26,  # King John
              richardii:     27,  # Richard II
              richardiii:    28,  # Richard III
              aandc:         29,  # Antony and Cleopatra
              coriolanus:    30,  # Coriolanus
              hamlet:        31,  # Hamlet
              lear:          32,  # Lear
              macbeth:       33,  # Macbeth
              othello:       34,  # Othello
              randj:         35,  # Romeo and Juliet
              timon:         36,  # Timon of Athens
              titus:         37,  # Titus Andronicus
              caesar:        38   # Julius Caesar
            }
            
            # Iterate through the play_routes hash and create routes for each play
            play_routes.each do |play_key, play_id|
              play_path = "/#{play_key}/?"
              # Create a route for the play
              get(Regexp.new(play_path, true)) { do_play(play_id)}
              # Create a route for the play with the gender_id parameter set to 3
              get(Regexp.new("/men#{play_path}/?", true)) { do_play(play_id, 3)}
              # Create a route for the play with the gender_id parameter set to 2
              get(Regexp.new("/women#{play_path}/?", true)) { do_play(play_id, 2)}
              # Create a route for the play with the gender_id parameter set to nil
              get(Regexp.new("/plays#{play_path}/?", true)) { do_play(play_id)}
            end