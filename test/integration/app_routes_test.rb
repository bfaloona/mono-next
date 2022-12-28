require_relative '../test_helper'

describe 'App routing' do

  it " / displays Temporary Site Maintenance" do
    get '/'
    _(last_response.status).must_equal 200
    _(last_response.body).must_include("Temporary Site Maintenance")
  end

  it " not found displays custom 404 page" do
    get '/zzz404error'
    _(last_response.status).must_equal 404
    # _(last_response.body).must_include("404 - File Not Found on Shakespeare's Monologues Site")
    _(last_response.body).must_include("Temporary Site Maintenance")
  end

  it " server error displays custom 500 page" do
    get '/zzz500error'
    # _(last_response.status).must_equal 500
    # _(last_response.body).must_include("We're sorry, but something went wrong")
    _(last_response.body).must_include("Temporary Site Maintenance")
  end

end
