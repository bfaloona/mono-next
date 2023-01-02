
#
# This file was originally written for Padrino 0.13 by
# Brandon Faloona, then migrated to Sinatra 3.0.5 by
# GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
# December 2022.
#

require "sinatra"

# Configure the application
configure do
  set :root, File.expand_path(File.dirname(__FILE__))
  set :public_folder, Proc.new { File.join(root, "public") }
end

# Load test configuration
require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

# MonologuePreviewSpec class for minitest
class MonologuePreviewSpec < Minitest::Capybara::Spec

  # Set Capybara driver to selenium chrome
  before(:each) do
    Capybara.current_driver = :selenium_chrome
    visit '/plays'
    fill_in('search-box', with: 'e')
  end

  # Test that expand works
  it 'expand works' do
    click_link('No more you petty spirits of region low')
    page.must_have_content('Upon your never-withering banks of flowers')
  end

  # Test that collapse works
  it 'collapse works' do
    click_link('No more you petty spirits of region low')
    page.must_have_content('Upon your never-withering banks of flowers')
    click_link('No more you petty spirits of region low')
    page.wont_have_content('Upon your never-withering banks of flowers')
  end

end