require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues Search Gender Men' do

  it ' /search/pinapples/m returns no pinapples!' do
    get '/search/pinapples/m'
    monologues_displayed(last_response).must_equal 0
  end

  it ' /search/twenty/m finds multiple matches' do
    get '/search/twenty/m'
    monologues_displayed(last_response).must_equal 3
  end

  it ' /search/amoung%20twenty/m returns one match' do
    get '/search/among%20twenty/m'
    monologues_displayed(last_response).must_equal 1

  end

  it ' /search/S/hame/m returns case insensitive results' do
    get '/search/Shame/m'
    monologues_displayed(last_response).must_equal 5
  end

end

