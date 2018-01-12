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

  scenario 'login with valid information' do
    user = create(:user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_link(href: login_path, count: 0)
    expect(page).to have_link(href: logout_path)
    expect(page).to have_link(href: user_path(user))

    click_link 'Log out'
    expect(page).to have_link(href: login_path)
    expect(page).to have_link(href: logout_path, count: 0)
    expect(page).to have_link(href: user_path(user), count: 0)
  end
end
