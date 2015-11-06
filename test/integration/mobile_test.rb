require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Monologues Mobile' do

  it ' /m/ returns table of monologues' do
    get '/m/'
    monologues_displayed(last_response).must_equal 20
  end

end

