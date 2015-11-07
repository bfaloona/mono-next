require File.expand_path(File.dirname(__FILE__) + '/../test/test_config.rb')
require 'rest-client'


describe "#{PROD_WEBSITE} validation of /monologues" do

  it '/monologues/2 returns second play' do
    response = RestClient.get full_url '/monologues/2'
    response.code.must_equal 200
    response.body.must_include 'Ophelia'
    response.body.must_include 'what a noble mind'
  end
end


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