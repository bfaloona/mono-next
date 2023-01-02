
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

require 'sinatra'

describe "Account Model" do
  it 'can construct a new instance' do
    # Instantiate a new Account object
    @account = Account.new
    
    # Assert that the object is not nil
    refute_nil @account
  end
end