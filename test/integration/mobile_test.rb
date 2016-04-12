require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues Mobile' do

  it ' /m/ returns table of monologues' do
    get '/m/'
    monologues_displayed(last_response).must_equal 24
  end

  it ' /m/131 returns expected monologue' do
    get '/m/131'
    last_response.body.split('Most welcome, bondage').count.must_equal 3 # including page title!
  end

  it ' /p/3 returns expected play' do
    get '/p/3'
    last_response.body.split('3 monologues').count.must_equal 2
    last_response.body.split('Cymbeline').count.must_equal 3 # including page title!
  end

end

