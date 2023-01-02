# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#
require 'sinatra'
require 'minitest/autorun'
require 'minitest/capybara'
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

# This class is a Minitest Capybara spec for the search feature
# of the Play model. 
class PlaySearchSpec < Minitest::Capybara::Spec
  # This method runs before each test and sets up the Capybara
  # driver and navigates to the play page. 
  before(:each) do
    Capybara.current_driver = :selenium_chrome
    visit '/plays/3'
  end
  
  # This test verifies that a search for "lost" returns
  # one monologue, and that the monologue does not contain
  # the phrase "Most welcome, bondage".
  it 'show scoped search works' do
    fill_in('search-box', with: 'lost')
    page.wont_have_content('Most welcome, bondage')
    monologues_displayed(page).must_equal 1
  end
end