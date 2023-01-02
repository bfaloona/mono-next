
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)

# Load our dependencies
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

# Use Protection against typical web attacks
require 'rack/protection'

# Allow redirection of old URLs to new
require 'rack/rewrite'

# Memcached support
require 'dalli'

# Enable devel logging
set :logging, Logger::DEBUG

# Enable logging of source location
set :show_exceptions, :after_handler

# Configure your I18n
I18n.default_locale = :en
I18n.enforce_available_locales = false

# Configure your HTML5 data helpers
helpers do
  def data_attribute(name, value = nil)
    value = value.to_s
    value = 'true' if value == ''
    "data-#{name.to_s.dasherize}=\"#{value}\""
  end
end

# Add helpers to mailer
class Mail::Message
  include Padrino::Helpers::NumberHelpers
  include Padrino::Helpers::TranslationHelpers
end

# Add your before (RE)load hooks here
before do
end

# Add your after (RE)load hooks here
after do
end