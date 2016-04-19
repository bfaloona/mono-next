require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class PlaySearchSpec < Minitest::Capybara::Spec

  before(:each) do
    Capybara.current_driver = :selenium_chrome
    visit '/plays/3'
  end

  it 'show scoped search works' do
    fill_in('search-box', with: 'lost')
    page.must_have_content('1 of 1 monologue')
  end

end

