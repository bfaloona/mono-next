
            # This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#
require 'sinatra'
require 'rspec'
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

# Require the test_config.rb file for the application
require_relative '../test_config.rb'

describe "Play Model" do
  # Create a new instance of the Play model
  it 'can construct a new instance' do
    @play = Play.new
    # Refute the nil value of the instance
    refute_nil @play
  end
end