require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

RACK_ENV = 'test' unless defined?(RACK_ENV)

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require 'minitest/capybara'
require 'mocha/api'

require 'rack/test'
require 'capybara'
require 'selenium-webdriver'

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

# Config and helper for prod tests
PROD_WEBSITE ||= 'shakespeare-monologues.org'


class MiniTest::Spec
  include Mocha::API
  include Rack::Test::Methods

  include Capybara::DSL
  include WaitForAjax

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  # You can use this method to custom specify a Rack app
  # you want rack-test to invoke:
  #
  #   app Monologues::App
  #   app Monologues::App.tap { |a| }
  #   app(Monologues::App) do
  #     set :foo, :bar
  #   end
  #
  def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Padrino.application
  end

end

Capybara.app = Monologues::App.new
Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use! [
                             Minitest::Reporters::SpecReporter.new,
                             Minitest::Reporters::DefaultReporter.new(reporter_options)
                         ]
