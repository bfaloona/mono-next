require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

describe "/plays" do

  before do
    get "/plays"
  end

  it "should return plays title" do
     last_response.body.must_include "Shakespeare's Monologues"
  end
end
