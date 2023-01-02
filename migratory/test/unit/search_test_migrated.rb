
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.

require 'sinatra'
require 'sinatra/json'
require 'json'

# Require the test_config.rb file
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues Search Gender Men' do

  # Test route for searching monologues
  post '/search' do
    # Parse the request body
    params = JSON.parse(request.body.read)
    # Get the query and gender from the params
    query = params['query']
    gender = params['gender']

    # Check if query is empty
    if query.empty?
      # Return no matches
      json monologues_displayed: 0
    else
      # Search for monologues
      results = Monologue.search(query, gender)
      # Return matches
      json monologues_displayed: results.count
    end
  end

  it ' Valid query for missing term returns no matches' do
    post '/search', {query: 'pinapple', gender: 'm'}.to_json
    monologues_displayed(last_response).must_equal 0
  end

  it ' General query returns multiple matches' do
    post '/search', {query: 'twenty', gender: 'm'}.to_json
    monologues_displayed(last_response).must_equal 3
  end

  it ' Exact query returns one match' do
    post '/search', {query: 'among twenty', gender: 'm'}.to_json
    monologues_displayed(last_response).must_equal 1
  end

  it ' Uppercase query returns case insensitive matches' do
    post '/search', {query: 'Shame', gender: 'm'}.to_json
    monologues_displayed(last_response).must_equal 5
  end

  it ' Punctuation in query returns correct match' do
    post '/search', {query: 'of battles! steel my soldiers\' hearts', gender: 'm'}.to_json
    last_response.body.must_include 'IV i 178'
  end

  it ' Trailing space in query returns correct match' do
    post '/search', {query: 'my complete master ', gender: 'w'}.to_json
    last_response.body.must_include 'my complete master'
  end

  #########
  # Pending
  #

  it ' Sans Punctuation in query returns correct match' do

    skip 'Not yet supported'

    post '/search', {query: 'of battles steel my soldiers hearts', gender: 'm'}.to_json
    last_response.body.must_include 'IV i 178'
  end


end