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
end
