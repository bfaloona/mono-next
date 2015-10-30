require_relative '../test_helper'
require_relative './test_prod_helper'

describe 'Production URL Validation' do

  BASEURL ||= 'http://www.shakespeare-monologues.org/'

  short_urls = {
      't.co/tRVowPAqyh' => 'Julius Caesar',
      'MonosBy.WS/mCaesar' => 'Julius Caesar',
  }

  it '/ contains phrase' do
    response = RestClient.get BASEURL + 'home'
    response.code.must_equal 200
    response.to_s.must_match(/Built for actors/)
  end

  it '/women contains phrase' do
    response = RestClient.get BASEURL + 'women'
    response.code.must_equal 200
    response.to_s.must_include('Women\'s Monologues in Shakespeare')
  end

  it '/men contains phrase' do
    response = RestClient.get BASEURL + 'men'
    response.code.must_equal 200
    response.to_s.must_include('Men\'s Monologues in Shakespeare')
  end

  short_urls.each do |url, play_name|
    it url do
      url = prepend_protocol(url)
      response = RestClient.get url
      response.code.must_equal 200
      response.to_s.must_include(play_name)
    end
  end

end