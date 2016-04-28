require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues routing' do

  it ' /plays/1 returns As You Like It' do
    get '/plays/1'
    last_response.body.must_include 'As You Like It'
  end

  it ' /plays/23?g=2 returns women filtered play' do
    get '/plays/23?g=2'
    monologues_displayed(last_response).must_equal 1
    last_response.body.must_include 'My Lord of Suffolk'
  end

  it ' /women/plays/23 returns women filtered play' do
    get '/women/plays/23'
    monologues_displayed(last_response).must_equal 1
    last_response.body.must_include 'My Lord of Suffolk'
  end

  it ' /plays/23?g=3 returns men filtered play' do
    get '/plays/23?g=3'
    monologues_displayed(last_response).must_equal 2
    last_response.body.must_include 'Is Cade the son of Henry the Fifth'
  end

  it ' /men/plays/23 returns men filtered play' do
    get '/men/plays/23'
    monologues_displayed(last_response).must_equal 2
    last_response.body.must_include 'Is Cade the son of Henry the Fifth'
  end

  it ' /monologues/813 returns: I cannot heave my heart' do
    get '/monologues/813'
    last_response.body.must_include 'Return those duties back as are right fit'
  end

  it 'post /search with query returns results' do
    post '/search', '{"query": "when", "gender": "m", "play": "3"}'
    monologues_displayed(last_response).must_equal 1
    last_response.body.must_include 'No blame be to you'
  end

end

