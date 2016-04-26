source 'https://rubygems.org'

# Padrino supports Ruby version 1.9 and later
ruby '2.3.1'

# Project requirements
gem 'rake'

# Padrino Stable Gem
gem 'padrino', '~> 0.13'

# Memcached support
gem 'dalli'

# TODO Re-enable rack protection!
gem 'rack-protection'


# Component requirements
gem 'activerecord', '>= 3.1', require: 'active_record'
gem 'haml'
gem 'pg'
gem 'rack-rewrite'
gem 'bcrypt'

# Test requirements
group :test do

  gem 'minitest', require: 'minitest/autorun'
  gem 'minitest-reporters', require: false
  gem 'minitest-capybara'
  gem 'mocha', require: false
  gem 'rack-test', require: 'rack/test'
  gem 'capybara'
  gem 'selenium-webdriver'


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

