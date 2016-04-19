require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues' do

  it 'root renders plays list' do
    get '/'
    last_response.body.must_include 'Tragedies'
  end

  it 'root renders left column ads' do
    skip 'ads suck during development'
    get '/'
    last_response.body.split('3862062942').count.must_equal 2
  end

  it 'root renders right column ads' do
    skip 'ads suck during development'
    get '/'
    last_response.body.split('1016396307').count.must_equal 2
  end

  it 'root renders link menus and footers' do
    skip 'ads suck during development'
    get '/'
    last_response.body.split('The Women').count.must_equal 3
    last_response.body.split('Chrome App').count.must_equal 2
    last_response.body.split('Contact').count.must_equal 3
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
