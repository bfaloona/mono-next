require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues Search Gender Men' do

  it ' Valid query for missing term returns no matches' do
    post '/search', {query: 'pinapple', gender: 3}.to_json
    monologues_displayed(last_response).must_equal 0
  end

  it ' General query returns multiple matches' do
    post '/search', {query: 'twenty', gender: 3}.to_json
    monologues_displayed(last_response).must_equal 3
  end

  it ' Exact query returns one match' do
    post '/search', {query: 'among twenty', gender: 3}.to_json
    monologues_displayed(last_response).must_equal 1
  end

  it ' Uppercase query returns case insensitive matches' do
    post '/search', {query: 'Shame', gender: 3}.to_json
    monologues_displayed(last_response).must_equal 5
  end

  it ' Punctuation in query returns correct match' do
    post '/search', {query: 'of battles! steel my soldiers\' hearts', gender: 3}.to_json
    last_response.body.must_include 'IV i 178'
  end

  it ' Trailing space in query returns correct match' do
    post '/search', {query: 'my complete master ', gender: 3}.to_json
    last_response.body.must_include 'my complete master'
  end

  #########
  # Pending
  #

  it ' Sans Punctuation in query returns correct match' do

    skip 'Not yet supported'

    post '/search', {query: 'of battles steel my soldiers hearts', gender: 3}.to_json
    last_response.body.must_include 'IV i 178'
  end


end

