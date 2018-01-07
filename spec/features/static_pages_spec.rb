require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  subject(:base_title) { 'Ruby on Rails Tutorial Sample App' }
  scenario 'should have the content Sample App' do
    visit root_path
    expect(page).to have_content('Sample App')
    expect(page).to have_title "Home | #{base_title}"
  end

  scenario 'should have the proper link in home' do
    visit root_path
    # in the logo and the left of the header
    expect(page).to have_link href: root_path, count: 2
    # in the header
    expect(page).to have_link href: help_path
    # in the footer
    expect(page).to have_link href: about_path
    # in the footer
    expect(page).to have_link href: contact_path
  end

  scenario 'should link home to signup page' do
    visit root_path
    click_link 'Sign up now!'
    expect(current_path).to eq signup_path
  end

  scenario 'should have the title about' do
    visit about_path
    expect(page).to have_title "About | #{base_title}"
  end

  scenario 'should have the title help' do
    visit help_path
    expect(page).to have_title "Help | #{base_title}"
  end

  scenario 'should have the title help' do
    visit contact_path
    expect(page).to have_title "Contact | #{base_title}"
  end
  
end
