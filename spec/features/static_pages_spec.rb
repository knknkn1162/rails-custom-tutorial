require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  describe 'visit signup_path' do
    scenario 'should link home to signup page' do
      visit root_path
      click_link 'Sign up now!'
      expect(current_path).to eq signup_path
    end
  end
end
