# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require_relative '../test/application_controller_spec'

include Rack::Test::Methods

def app
  Sinatra::Application
end

