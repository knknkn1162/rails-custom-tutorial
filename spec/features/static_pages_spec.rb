require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  describe 'visit signup_path' do
    scenario 'should link home to signup page' do
      visit root_path
      click_link 'Sign up now!'
      expect(current_path).to eq signup_path
    end
  end

  describe 'visit users_path' do
    scenario 'should have the proper link as login user' do
      user = create(:user)
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'

      visit users_path
      # in the logo and the left of the header
      expect(page).to have_link href: root_path, count: 2
      # in the header
      expect(page).to have_link href: help_path
      # in the footer
      expect(page).to have_link href: about_path
      # in the footer
      expect(page).to have_link href: contact_path
      expect(page).to have_selector('ul>li>img')
      expect(page).to have_link href: user_path(user), text: user.name
    end

    scenario 'should redirect to login_url as non-login user' do
      user = create(:user)
      # without log-in
      visit users_path

      expect(current_path).to eq login_path
    end
  end

end
