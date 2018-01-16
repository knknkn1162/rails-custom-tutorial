require 'rails_helper'

RSpec.feature "PasswordResets", type: :feature do
  before :each do
    clear_emails
  end

  let(:post_password_reset) {
    user = create(:user)
    visit new_password_reset_path
    fill_in 'Email', with: user.email
    click_button 'Submit'
    open_email(user.email)
    current_email.click_link 'Reset password'
    expect(page).to have_title 'Reset password'
  }

  describe 'visit new_pathword_reset_path' do
    scenario 'login with valid information' do
      user = create(:user)
      visit new_password_reset_path
      fill_in 'Email', with: user.email
      click_button 'Submit'
      expect(current_path).to eq root_path
    end
  end

  describe 'visit edit_password_reset_path' do
    scenario 'doesnt match password & password_confirmation' do
      post_password_reset
      fill_in 'Password', with: 'foobaz'
      fill_in 'Confirmation', with: 'barquux'
      click_button 'Update password'
      expect(page).to have_selector('div#error_explanation')
    end

    scenario 'empty password' do
      post_password_reset
      fill_in 'Password', with: 'foobaz'
      fill_in 'Confirmation', with: 'barquux'
      click_button 'Update password'
      expect(page).to have_selector('div#error_explanation')
    end
  end
end
