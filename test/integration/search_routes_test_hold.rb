require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Search routing' do

  it 'post /search with play, gender and query' do
    post '/search', '{"query": "when", "gender": "m", "play": "3"}'
    _(last_response.body).must_include 'No blame be to you'
    _(monologues_displayed(last_response)).must_equal 1
  end

  it 'post /search with query e' do
    post '/search', '{"query": "e", "gender": "a", "play": ""}'
    _(monologues_displayed(last_response)).must_equal 24
  end

  it 'post /search with no params' do
    post '/search', '{}'
    _(monologues_displayed(last_response)).must_equal 24
  end

end
