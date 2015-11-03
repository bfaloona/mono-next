source 'https://rubygems.org'

# Padrino supports Ruby version 1.9 and later
ruby '2.2.1'

# Project requirements
gem 'rake'

# Padrino Stable Gem
gem 'padrino', '0.13.0'

# Component requirements
gem 'activerecord', '>= 3.1', require: 'active_record'
gem 'haml'
gem 'pg'
gem 'rack-protection'
gem 'rack-rewrite'
gem 'bcrypt'

# Test requirements
group :test do

  gem 'minitest', require: 'minitest/autorun'
  gem 'minitest-reporters', require: false
  gem 'mocha', require: false
  gem 'rack-test', require: 'rack/test'

  # rest-client for http calls
  gem 'rest-client', require: false

  #gem 'autotest', require: false

  # guard runs tests
  gem 'guard'
  gem 'guard-minitest', require: false
  gem 'terminal-notifier-guard', require: false
  gem 'rb-fsevent', require: false

  # pry for debugging
  gem 'pry', require: false
  gem 'pry-padrino', require: false

end

