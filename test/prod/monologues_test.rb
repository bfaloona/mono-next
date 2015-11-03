require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
require 'rest-client'

describe "#{PROD_WEBSITE} validation of /monologues" do

  it '/monologues/2 returns second play' do
    response = RestClient.get full_url '/monologues/2'
    response.code.must_equal 200
    response.body.must_include 'Ophelia'
    response.body.must_include 'what a noble mind'
  end
end
