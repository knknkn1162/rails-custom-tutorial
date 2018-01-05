require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  subject(:base_title) { 'Ruby on Rails Tutorial Sample App' }
  scenario 'should have the content Sample App' do
    visit root_url
    expect(page).to have_content('Sample App')
  end

  scenario 'should have the title Home' do
    visit static_pages_home_url
    expect(page).to have_title "Home | #{base_title}"
  end

  scenario 'should have the title about' do
    visit static_pages_about_url
    expect(page).to have_title "About | #{base_title}"
  end

  scenario 'should have the title help' do
    visit static_pages_help_url
    expect(page).to have_title "Help | #{base_title}"
  end
end
