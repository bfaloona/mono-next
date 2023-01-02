
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#

require 'sinatra'
require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

RACK_ENV = 'test' unless defined?(RACK_ENV)

# Require the necessary testing gems
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require 'minitest/capybara'
require 'mocha/api'

# Require Rack and Capybara
require 'rack/test'
require 'capybara'
require 'selenium-webdriver'

# Require the boot file
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

# Config and helper for prod tests
PROD_WEBSITE ||= 'shakespeare-monologues.org'

# Set up the MiniTest spec
class MiniTest::Spec
  include Mocha::API
  include Rack::Test::Methods

  include Capybara::DSL

  # Teardown method to reset sessions and use the default driver
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  # Method to specify a Rack app
  def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Sinatra::Application
  end

end

# Set Capybara app and register the Selenium Chrome driver
Capybara.app = Sinatra::Application
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

# Set up the reporters
reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use! [
                             Minitest::Reporters::SpecReporter.new,
                             Minitest::Reporters::DefaultReporter.new(reporter_options)
                         ]