require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class MonologuePreviewSpec < Minitest::Capybara::Spec

  before(:each) do
    Capybara.current_driver = :selenium_chrome
    visit '/'
  end

  it 'expand works' do
    click_link('No more you petty spirits of region low')
    page.must_have_content('Sky-planted batters all rebelling coasts')
  end

  it 'expand works after search' do
    fill_in('search-box', with: 'z')
    click_link('Neither of either; I remit both twain')
    page.must_have_content('Knowing aforehand of our merriment')
  end

  it 'collapse works' do
    click_link('No more you petty spirits of region low')
    page.must_have_content('Sky-planted batters all rebelling coasts')
    click_link('No more you petty spirits of region low')
    page.wont_have_content('Sky-planted batters all rebelling coasts')
  end

  it 'expand works after search' do
    fill_in('search-box', with: 'z')
    click_link('Neither of either; I remit both twain')
    page.must_have_content('Knowing aforehand of our merriment')
    click_link('Neither of either; I remit both twain')
    page.wont_have_content('Knowing aforehand of our merriment')
  end

end