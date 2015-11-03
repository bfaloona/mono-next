require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')
require 'rest-client'

describe "#{PROD_WEBSITE} Redirect validation" do

  short_urls = {
      't.co/tRVowPAqyh' => 'Julius Caesar',
      'MonosBy.WS/mCaesar' => 'Julius Caesar',
  }

  short_urls.each do |url, play_name|
    it url do
      url = prepend_protocol(url)
      response = RestClient.get url
      response.code.must_equal 200
      response.to_s.must_include(play_name)
    end

  end

  it '/ contains phrase' do
      response = RestClient.get full_url '/home'
      response.code.must_equal 200
      response.to_s.must_match(/Built for actors/)
    end

    it '/women contains phrase' do
      response = RestClient.get full_url '/women'
      response.code.must_equal 200
      response.to_s.must_include('Women\'s Monologues in Shakespeare')
    end

    it '/men contains phrase' do
      response = RestClient.get full_url '/men'
      response.code.must_equal 200
      response.to_s.must_include('Men\'s Monologues in Shakespeare')
    end

end