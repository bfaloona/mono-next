require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues Search Gender Men' do

  it ' Valid query for missing term returns no matches' do
    get '/search/pinapples/m'
    monologues_displayed(last_response).must_equal 0
  end

  it ' General query returns multiple matches' do
    get '/search/twenty/m'
    monologues_displayed(last_response).must_equal 3
  end

  it ' Exact query returns one match' do
    get '/search/among%20twenty/m'
    monologues_displayed(last_response).must_equal 1
  end

  it ' Uppercase query returns case insensitive matches' do
    get '/search/Shame/m'
    monologues_displayed(last_response).must_equal 5
  end

  it ' Punctuation in query returns correct match' do
    get '/search/of%20battles!%20steel%20my%20soldiers\'%20hearts/m'
    last_response.body.must_include 'IV i 178'
  end

  it ' Trailing space in query returns correct match' do
    get '/search/my%20complete%20master%20/m'
    last_response.body.must_include 'my complete master'
  end

  #########
  # Pending
  #

  it ' Sans Punctuation in query returns correct match' do
    skip 'Not yet supported'
    get '/search/of%20battles%20steel%20my%20soldiers%20hearts/m'
    last_response.body.must_include 'IV i 178'
  end


end

