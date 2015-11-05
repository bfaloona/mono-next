require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues' do

  it 'root renders' do
    get '/'
    last_response.body.must_include 'found, '
  end

  it 'homepage renders' do
    get '/home'
    last_response.body.must_include 'Making it easier to find monologues since 1997'
  end

  it ' /invalid_path returns 404' do
    get '/invalid_path'
    assert last_response.not_found?
  end

end
