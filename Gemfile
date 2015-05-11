source 'https://rubygems.org'

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'rack-rewrite'
gem 'rack-maintenance', :require => 'rack/maintenance'
gem 'sass'
gem 'haml'

# Test requirements
gem 'mocha', :group => 'test', :require => false
gem 'minitest', :require => 'minitest/autorun', :group => 'test'
gem 'rack-test', :require => 'rack/test', :group => 'test'

# Padrino Stable Gem
gem 'padrino', '0.12.5'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.12.5'
# end

group 'test', 'development' do
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
  gem 'bond'
end
gem 'plymouth', require: false, group: 'test'
