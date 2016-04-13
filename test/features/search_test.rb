require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class PlaySearchSpec < Minitest::Capybara::Spec

  before(:each) do
    Capybara.current_driver = :selenium_chrome
  end

  it 'show scoped search works' do
    visit '/plays/3'
    fill_in('search-box', with: 'lost')
    page.must_have_content('1 of 1 monologue')
  end

end

