
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#
require 'sinatra'
require 'sinatra/activerecord'
require 'data_mapper'
require 'yaml'

class Account < ActiveRecord::Base
  validates :email, :name, :surname, :password, presence: true
  validates :password, confirmation: true
  validates :role, inclusion: { in: %w(admin user) }
end

class Gender < ActiveRecord::Base
  validates :name, presence: true
end

class Author < ActiveRecord::Base
  validates :name, presence: true
end

class Play < ActiveRecord::Base
  validates :author_id, :classification, :title, presence: true
end

# Set up test database with fixtures
if Sinatra::Base.development?
  ##
  # Account
  ##
  account = Account.new(
      email: 'admin@domain.tld', 
      name: 'Admin', 
      surname: 'Guy', 
      password: 'soverysecure!', 
      password_confirmation: 'soverysecure!', 
      role: 'admin')
  if account.valid?
    account.save
  else
    account.errors.full_messages.each { |m| puts "   - #{m}" }
    raise 'Error creating account'
  end

  ##
  # Genders and Author
  ##
  Gender.create!(name: 'Both')
  Gender.create!(name: 'Women')
  Gender.create!(name: 'Men')
  Author.create!(name: 'Shakespeare')

  ##
  # Plays
  ##
  Play.create!(author_id: 1, classification: 'Comedy', title: 'As You Like It')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'The Comedy of Errors')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Cymbeline')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Loves Labours Lost')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'The Merchant of Venice')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Much Ado About Nothing')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'The Taming of the Shrew')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Twelfth Night, Or What You Will')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Alls Well That Ends Well')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Measure for Measure')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Merry Wives of Windsor')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Merchant of Venice')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'A Midsummer Nights Dream')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'The Tempest')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Troilus and Cressida')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Two Gentlemen of Verona')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'The Winters Tale')
  Play.create!(author_id: 1, classification: 'Comedy', title: 'Pericles, Prince of Tyre')
  Play.create!(author_id: 1, classification: 'History', title: 'Henry IV i')
  Play.create!(author_id: 1, classification: 'History', title: 'Henry IV ii')
end

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