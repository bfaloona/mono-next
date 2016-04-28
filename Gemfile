source 'https://rubygems.org'
ruby '2.3.0'
gem 'rake'

# Padrino Stable Gem
gem 'padrino', '~> 0.13'

# Memcached support
gem 'dalli'

# TODO Re-enable rack protection!
gem 'rack-protection'

# Component requirements
gem 'activerecord', '~> 4.2', require: 'active_record'
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

  # rest-client for making http calls
  gem 'rest-client', require: false
end

# Local development requirements
group :development do
  # guard runs tests automatically
  gem 'guard'
  gem 'guard-minitest', require: false
  gem 'terminal-notifier-guard', require: false
  gem 'rb-fsevent', require: false

  # pry for debugging
  gem 'pry', require: false
  gem 'pry-padrino', require: false
end

