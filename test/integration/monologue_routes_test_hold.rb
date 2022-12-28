require_relative '../test_helper'

describe 'Monologues routing' do

  it ' /monologues/813 returns: I cannot heave my heart' do
    get '/monologues/813'
    _(last_response.body).must_include 'Return those duties back as are right fit'
  end

end
