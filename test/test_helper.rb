require 'minitest/spec'
require 'minitest/autorun'
require "minitest/reporters"
require 'rack/test'
require 'mocha/api'
require 'vcr'

RACK_ENV = 'test' unless defined?(RACK_ENV)
Minitest::Reporters.use!

require File.expand_path '/../../config/boot', __FILE__

class MiniTest::Spec
  include Mocha::API
  include Rack::Test::Methods

  # You can use this method to custom specify a Rack app
  # you want rack-test to invoke:
  #
  # app MonoNext::Monologues
  # app MonoNext::Monologues.tap { |a| }
  # app(MonoNext::Monologues) do
  # set :foo, :bar
  # end

  def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Padrino.application
  end
end
