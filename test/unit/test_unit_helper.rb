require 'rack/test'

RACK_ENV = 'test' unless defined?(RACK_ENV)
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

require File.dirname(__FILE__) + '/../../config/boot'

class MiniTest::Spec
  include Rack::Test::Methods

  def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Padrino.application
  end
end
