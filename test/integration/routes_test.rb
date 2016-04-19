require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues routing' do

  it ' /plays/1 returns As You Like It' do
    get '/plays/1'
    last_response.body.must_include 'As You Like It'
  end

  it ' /monologues/813 returns: I cannot heave my heart' do
    get '/monologues/813'
    last_response.body.must_include 'Return those duties back as are right fit'
  end

  it 'post /search with query returns results' do
    post '/search', '{"query": "when", "gender": "m", "play": "3"}'
    last_response.body.must_include '1 of 1 monologues'
    last_response.body.must_include 'No blame be to you'
  end

end

