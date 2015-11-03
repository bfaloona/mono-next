require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

require 'rest-client'

describe 'Production URL Validation' do

  BASEURL ||= 'http://www.shakespeare-monologues.org/'

  it '/monologues/2 returns second play' do
    response = RestClient.get BASEURL + 'monologues/2'
    response.code.must_equal 200
    response.body.must_include 'Ophelia'
    response.body.must_include 'what a noble mind'
  end
end
