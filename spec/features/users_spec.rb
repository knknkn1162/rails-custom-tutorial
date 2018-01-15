require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario 'fill in invalid_user' do
    visit signup_path
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'foo@invalid.com'
    fill_in 'Password', with: 'foo'
    fill_in 'Confirmation', with: 'bar'
    click_on 'Create my account'

    expect(page).to have_selector('div#error_explanation')
    expect(page).to have_selector('div.alert')
  end

  describe 'visit user_path' do
    scenario 'login with valid information' do
      user = create(:user)
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(current_path).to eq user_path(user)
      expect(page).to have_link(href: login_path, count: 0)
      expect(page).to have_link(href: logout_path)
      expect(page).to have_link(href: user_path(user))

      click_link 'Log out'
      expect(current_path).to eq root_path
      expect(page).to have_link(href: login_path)
      expect(page).to have_link(href: logout_path, count: 0)
      expect(page).to have_link(href: user_path(user), count: 0)
    end
  end

  describe 'visit users_path' do
    scenario 'should have the proper link as login user' do
      user = create(:user)
      # make many users for multiple pagination
      100.times do |i|
        create(:user, email: "example-#{i}@example.com")
      end

      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
      expect(current_path).to eq(user_path(user))
      visit users_path
      # is exist pagination
      # in the logo and the left of the header
      expect(page).to have_link href: root_path, count: 2
      # in the header
      expect(page).to have_link href: help_path
      # in the footer
      expect(page).to have_link href: about_path
      # in the footer
      expect(page).to have_link href: contact_path
      expect(page).to have_selector('div.pagination', count: 2)

      User.paginate(page: 1).each do |u|
        expect(page).to have_selector('ul>li>img.gravatar')
        expect(page).to have_link href: user_path(u), text: u.name
      end
    end

    scenario 'should redirect to login_url as non-login user' do
      create(:user)
      # without log-in
      visit users_path

      expect(current_path).to eq login_path
    end
  end
end
