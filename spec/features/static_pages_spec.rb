require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  scenario 'should have the content Sample App' do
    visit '/static_pages/home'
    expect(page).to have_content('Sample App')
  end

  scenario 'should have the title Home' do
    visit '/static_pages/home'
    expect(page).to have_title 'Home | Ruby on Rails Tutorial Sample App'
  end

  scenario 'should have the title about' do
    visit '/static_pages/about'
    expect(page).to have_title 'About | Ruby on Rails Tutorial Sample App'
  end

  scenario 'should have the title help' do
    visit '/static_pages/help'
    expect(page).to have_title 'Help | Ruby on Rails Tutorial Sample App'
  end
end
