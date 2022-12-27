require_relative '../test_helper'

describe 'Plays routing' do

  it ' /plays/1 returns As You Like It' do
    get '/plays/1'
    _(last_response.body).must_include 'As You Like It'
  end

  it ' /plays/23?g=2 returns women filtered play' do
    get 'women/plays/23'
    _(last_response.body).must_include 'My Lord of Suffolk'
    _(monologues_displayed(last_response)).must_equal 1
  end

  it ' /women/plays/23 returns women filtered play' do
    get '/women/plays/23'
    _(last_response.body).must_include 'My Lord of Suffolk'
    _(monologues_displayed(last_response)).must_equal 1
  end

  it ' /plays/23?g=3 returns men filtered play' do
    get 'men/plays/23'
    _(last_response.body).must_include 'Is Cade the son of Henry the Fifth'
    _(monologues_displayed(last_response)).must_equal 2
  end

  it ' /men/plays/813?expand=0 displays monologues collapsed' do
    get '/men/plays/813?expand=0'
    _(last_response.body).must_include 'Return those duties back as are right fit'
    _(last_response.body).wont_include "\"toggle\": \"expand\""
  end

  it ' /men/plays/3?expand=1 displays monologues expanded' do
    get '/men/plays/3?expand=1'
    _(last_response.body).must_include "I'll speak to thee in silence."
  end

  it ' /men/plays/23 returns men filtered play' do
    get '/men/plays/23'
    _(last_response.body).must_include 'Is Cade the son of Henry the Fifth'
    _(monologues_displayed(last_response)).must_equal 2
  end

end
