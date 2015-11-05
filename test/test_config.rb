require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

RACK_ENV = 'test' unless defined?(RACK_ENV)

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require 'mocha/api'

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

# Config and helper for prod tests
PROD_WEBSITE ||= 'shakespeare-monologues.org'


class MiniTest::Spec
  include Mocha::API
  include Rack::Test::Methods

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

reporter_options = { color: true, slow_count: 5 }
Minitest::Reporters.use! [
                             Minitest::Reporters::SpecReporter.new,
                             Minitest::Reporters::DefaultReporter.new(reporter_options)
                         ]
