
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

require 'sinatra'
require 'sinatra/activerecord'
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Author Model" do
  # This section of code tests the ability to construct a new instance of the Author Model
  it 'can construct a new instance' do
    @author = Author.new
    refute_nil @author
  end
end