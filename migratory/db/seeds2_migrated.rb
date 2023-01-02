
            #
            # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            
            require 'sinatra'
            require 'data_mapper'
            require 'yaml'
            
            # Establish a connection to the database
            DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
            
            # Create the Play model
            class Play
              include DataMapper::Resource
              property :id, Serial
              property :author_id, Integer
              property :classification, String
              property :title, String
            end
            
            # Create the Monologue model
            class Monologue
              include DataMapper::Resource
              property :id, Serial
              property :play_id, Integer
              property :character, String
              property :text, Text
            end
            
            # Create the Account model
            class Account
              include DataMapper::Resource
              property :id, Serial
              property :email, String
              property :name, String
              property :surname, String
              property :password, BCryptHash
              property :role, String
            end
            
            # Finalize the models
            DataMapper.finalize
            DataMapper.auto_upgrade!
            
            # Create the plays
            Play.create!(author_id: 1, classification: 'History', title: 'Henry V')
            Play.create!(author_id: 1, classification: 'History', title: 'Henry VI i')
            Play.create!(author_id: 1, classification: 'History', title: 'Henry VI ii')
            Play.create!(author_id: 1, classification: 'History', title: 'Henry VI iii')
            Play.create!(author_id: 1, classification: 'History', title: 'Henry VIII')
            Play.create!(author_id: 1, classification: 'History', title: 'King John')
            Play.create!(author_id: 1, classification: 'History', title: 'Richard II')
            Play.create!(author_id: 1, classification: 'History', title: 'Richard III')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'Antony & Cleopatra')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'Coriolanus')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'Hamlet')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'King Lear')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'Macbeth')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'Othello')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'Romeo and Juliet')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'Timon of Athens')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'Titus Andronicus')
            Play.create!(author_id: 1, classification: 'Tragedy', title: 'Julius Caesar')
            
            # Create the monologues
            # Load monologues from the YAML file
            YAML.load_file('test/fixtures/monologues.yml').each do |monologue|
              Monologue.create!(monologue)
            end
            
            # Create admin account
            get '/setup' do
              email     = params[:email]
              password  = params[:password]
              account = Account.new(email: email, name: "Foo", surname: "Bar", password: password, password_confirmation: password, role: "admin")
              if account.valid?
                account.save
                "Account has been successfully created, now you can login with email: #{email} and password: #{password}"
              else
                "Sorry, but something went wrong!"
              end
            end