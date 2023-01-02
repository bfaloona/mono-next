
            # This file was originally written for Padrino 0.13 by
            # Brandon Faloona, then migrated to Sinatra 3.0.5 by
            # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
            # December 2022.
            #
            require 'sinatra'
            require 'sinatra/activerecord'
            require './models/monologue'
            
            # Establish a connection to the database
            configure do
              set :database, {adapter: 'sqlite3', database: 'db/monologue.db'}
            end
            
            # Describe Monologue Model
            describe "Monologue Model" do
              # Test gender scope with no parameter
              it 'gender scope returns all without a parameter' do
                @monologues = Monologue.all
                @monologues.length.must_equal 24
              end
              
              # Test gender and matching scopes combined
              it 'matching and gender scopes can be combined' do
                @monologues = Monologue.where(gender: 'm').where('title LIKE ?', '%z%')
                @monologues.length.must_equal 4
              end
              
              # Test matching scope
              it 'matching scope works' do
                @monologues = Monologue.where('title LIKE ?', '%z%')
                @monologues.length.must_equal 5
              end
            end