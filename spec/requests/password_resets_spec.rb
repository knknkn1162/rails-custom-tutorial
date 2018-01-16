require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  before :each do
    ActionMailer::Base.deliveries.clear
  end

  let(:post_password_reset) {
    user = create(:user)
    post password_resets_path, params: {
      password_reset: { email: user.email }
    }
    assigns(:user)
  }

  let(:edit_password_reset) {
    user = post_password_reset
    get edit_password_reset_path(user.reset_token, email: user.email)
    user
  }

  describe "GET /edit" do
    it 'doesnt work when email is invalid' do
      user = post_password_reset
      get edit_password_reset_path(user.reset_token, email: '')
      expect(response).to redirect_to(root_url)
    end
    it 'doesnt work with invalid user' do
      user = post_password_reset
      user.toggle!(:activated)
      get edit_password_reset_path(user.reset_token, email: user.email)

      expect(response).to redirect_to(root_url)
    end

    it 'doesnt work with only invalid token' do
      user = post_password_reset
      get edit_password_reset_path('wrong token', email: user.email)
      expect(response).to redirect_to(root_url)
    end

    it 'works with valid users and reset_token' do
      user = edit_password_reset
      get edit_password_reset_path(user.reset_token, email: user.email)
      patch password_reset_path(user.reset_token), params: {
        email: user.email,
        user: {
          password: 'foobaz',
          password_confirmation: 'foobaz'
        }
      }
      expect(session[:user_id]).to be
      expect(flash).not_to be_empty
      expect(response).to redirect_to(user_path(user))
    end
  end
end
