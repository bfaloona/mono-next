RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'mocha/api'

Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

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

def prepend_protocol url
  return url.match(/^https?\:\/\//) ? url : 'http://' + url
end