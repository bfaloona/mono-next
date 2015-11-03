require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "/plays" do

  it "should return heading title" do
    get "/plays"
    last_response.body.must_include "Shakespeare's Monologues"
    last_response.status.must_equal 200
  end
end

describe "/plays/2" do

  it "should return play's title" do
    skip('Fails with: Sinatra doesn\'t know this ditty.')
    get "/plays2"
    last_response.body.must_include "As You Like It"
    last_response.status.must_equal 200
  end
end
