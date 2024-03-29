# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require 'rack/test'
require 'rack/test'

require_relative '../config/environment'

def app
  Sinatra::Application
end

def monologues_displayed(response)
  response.body.downcase.split('firstline').count - 1
end


# Config and helper for prod tests
PROD_WEBSITE ||= 'shakespeare-monologues.org'


class MiniTest::Spec
  # include Mocha::API
  include Rack::Test::Methods

  # include Capybara::DSL

  # def teardown
  #   Capybara.reset_sessions!
  #   Capybara.use_default_driver
  # end

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
    @app ||= Sinatra::Application
  end

end

# Capybara.app = Monologues::App.new
# Capybara.register_driver :selenium_chrome do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use! [
                           # Minitest::Reporters::SpecReporter.new,
                           Minitest::Reporters::DefaultReporter.new(reporter_options)
                         ]

