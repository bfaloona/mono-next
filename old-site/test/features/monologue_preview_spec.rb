require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class MonologuePreviewSpec < Minitest::Capybara::Spec

  before(:each) do
    Capybara.current_driver = :selenium_chrome
    visit '/plays'
    fill_in('search-box', with: 'e')
  end

  it 'expand works' do
    click_link('No more you petty spirits of region low')
    page.must_have_content('Upon your never-withering banks of flowers')
  end

  it 'collapse works' do
    click_link('No more you petty spirits of region low')
    page.must_have_content('Upon your never-withering banks of flowers')
    click_link('No more you petty spirits of region low')
    page.wont_have_content('Upon your never-withering banks of flowers')
  end

end
