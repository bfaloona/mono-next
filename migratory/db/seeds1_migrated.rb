
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#
require 'sinatra'
require 'sinatra/activerecord'

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