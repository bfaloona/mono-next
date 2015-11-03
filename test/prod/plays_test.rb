require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
require 'rest-client'

describe "#{PROD_WEBSITE} validation of /plays" do

  it '/plays returns categories' do
    response = RestClient.get full_url '/plays'
    response.code.must_equal 200
    response.body.must_include 'Histories'
  end

  it '/plays/31 returns hamlet' do
    response = RestClient.get full_url '/plays/31'
    response.code.must_equal 200
    response.body.must_include 'Hamlet'
    response.body.must_include 'Tis now the very witching time of night'
  end

end
