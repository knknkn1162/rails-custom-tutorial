require 'rails_helper'

RSpec.feature "Microposts", type: :feature do
  include ApplicationHelper
  let(:home_with_log_in) {
    user = create(:user_with_posts)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_link 'Home'
    user
  }

  describe 'visit root_path after logging in' do
    scenario 'login with valid information' do
      user = home_with_log_in
      expect(page).to have_selector('div.pagination')
      expect(page).to have_selector('input[type=file]')

      fill_in 'micropost_content', with: 'The sample content'
      click_button 'Post'
      expect(page).to have_selector('a', text: 'delete')
    end

    scenario 'cant delete other micropost' do
      user = home_with_log_in
      other = create(:other) do |user|
        user.microposts.create(attributes_for(:micropost))
      end
      click_link 'Users'
      expect(page).to have_title(full_title("All users"))
      click_link other.name
      expect(page).to have_selector('ol.microposts li', count: 1)
      expect(page).to have_selector('a', text: 'delete', count: 0)
    end

    scenario 'display total microposts' do
      user = create(:user)
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      click_link 'Home'
      expect(page).to have_content '0 microposts'

      fill_in 'micropost_content', with: 'sample content'
      attach_file 'micropost_picture', 'spec/fixtures/rails.png'
      click_button 'Post'
      expect(page).to have_content '1 micropost'
      # check img posted
      expect(page).to have_selector('span.content img', count: 1)
    end
  end
end
