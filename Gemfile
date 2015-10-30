source 'https://rubygems.org'

# Project requirements
ruby '2.2.1'
gem 'rake'

# Component requirements
gem 'rack-protection'
gem 'rack-rewrite'
gem 'rack-maintenance', :require => 'rack/maintenance'
gem 'sass'
gem 'haml'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'pg'

# Padrino Stable Gem
gem 'padrino', '>= 0.13'

# Dev / Test requirements
group 'test', 'development' do
  gem 'minitest', require: 'minitest/autorun'
  gem 'minitest-reporters'
  gem 'rack-test', require: 'rack/test'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
  gem 'bond'
  gem 'rest-client'
  # gem 'mocha', require: false
end
