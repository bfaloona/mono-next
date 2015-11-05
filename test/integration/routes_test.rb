require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues routing' do

  it ' /plays/1 returns As You Like It' do
    get '/plays/1'
    last_response.body.must_include 'As You Like It'
  end

  it ' /monologues/813 returns: I cannot heave my heart' do
    get '/monologues/813'
    last_response.body.must_include 'I cannot heave my heart'
  end

  # it 'get /api/monologues returns 500' do
  #   get '/api/monologues'
  #   last_response.body.must_include '500 Server'
  # end

  it 'post /api/monologues without query returns error' do
    post '/api/monologues', '{"data": ""}'
    last_response.body.must_include '500 Server'
  end

end

