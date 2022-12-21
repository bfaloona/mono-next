require 'minitest/autorun'
require 'minitest/spec'
require './app/controllers/application_controller'
require 'sinatra'
require_relative 'spec_helper'
def app
  ApplicationController
end

describe ApplicationController do
  it "responds with a welcome message" do
    get '/'
    _(last_response.status).must_equal 200
    _(last_response.body).must_include("Welcome to the Sinatra Template!")
  end
end
