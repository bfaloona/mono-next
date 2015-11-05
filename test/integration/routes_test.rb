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

  it 'get /api/monologues returns 500' do
    skip('bug')
    get '/api/monologues'
    last_response.status.must_equal 500
  end

  it 'post /api/monologues without query returns sorry message' do
    skip('bug ')
    post '/api/monologues', '{"data": ""}'
    last_response.status.must_equal 500
    last_response.body.must_include 'sorry, but something went wrong'
  end

end

