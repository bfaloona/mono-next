# frozen_string_literal: true

#####
#
# Run with: bundle exec rake db:seed -e [test | development]
#
# Locally, this task sets up test database with fixtures
#
# Also used (via -e development) to create the first account for admin app.
#
#####
require_relative '../app/admin/models/account'
require_relative '../app/models/author'
require_relative '../app/models/play'
require_relative '../app/models/monologue'
require_relative '../app/models/gender'

if true || ENV['RACK_ENV'] == 'test'

  ##
  # Account
  ##
  account = Account.new(
    email: 'admin@domain.tld',
    name: 'Admin',
    surname: 'Guy',
    password: 'soverysecure!',
    password_confirmation: 'soverysecure!',
    role: 'admin'
  )
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

  ##
  # Monologues
  ##
  YAML.load_file('test/fixtures/monologues.yml').each do |monologue|
    Monologue.create!(monologue)
  end

# else
  # development

  email = 'brandon@faloona.net'
  password = ENV['SEED_PWD']

  account = Account.new(email: email, name: 'Foo', surname: 'Bar', password: password, password_confirmation: password, role: 'admin')

  if account.valid?
    account.save
    puts '================================================================='
    puts 'Account has been successfully created, now you can login with:'
    puts '================================================================='
    puts "   email: #{email}"
    puts "   password: #{?* * password.length}"
    puts '================================================================='
  else
    puts 'Sorry, but something went wrong!'
    puts ''
    account.errors.full_messages.each { |m| puts "   - #{m}" }
  end

end
