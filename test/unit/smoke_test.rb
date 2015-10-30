require_relative '../test_helper'
require_relative './test_unit_helper'

describe 'Monologues' do

  it 'homepage contains phrase' do
    get '/'
    last_response.body.must_include 'Making it easier to find monologues since 1997'
  end

  it '/a contains phrase' do
    get '/a'
    last_response.body.must_include 'Making it easier to find monologues since 1997'
  end

  it '/b returns 404' do
    get '/b'
    assert last_response.not_found?
  end

end