require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues Search' do

  it ' /search/pinapples returns no pinapples!' do
    get '/search/pinapples'
    monologues_displayed(last_response).must_equal 0
  end

  it ' /search/twenty finds multiple matches' do
    get '/search/twenty'
    monologues_displayed(last_response).must_equal 3
  end

  it ' /search/amoung%20twenty returns one match' do
    get '/search/among%20twenty'
    monologues_displayed(last_response).must_equal 1

  end

  it ' /search/Shame returns case insensitive results' do
    get '/search/Shame'
    monologues_displayed(last_response).must_equal 5
  end

end

