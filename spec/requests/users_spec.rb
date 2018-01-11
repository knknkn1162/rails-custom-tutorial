require 'rails_helper'

RSpec.describe "Users", type: :request do
  subject(:invalid_user) {
    {
        name: '',
        email: 'foo@invalid',
        password: 'foo',
        password_confirmation: 'bar'
    }
  }

  describe "GET /signup" do
    it 'submit with invalid users' do
      get signup_path
      expect(response).to have_http_status(200)
      expect { post users_path, params: { user: invalid_user } }.to change(User, :count).by(0)
      expect(response).to render_template(:new)
    end

    it 'submit with valid users' do
      get signup_path
      expect { post users_path, params: { user: attributes_for(:user) } }.to change(User, :count).by(1)
      expect(response).to redirect_to(assigns(:user))

      follow_redirect!
      expect(response).to render_template(:show)
      # assume success signup
      expect(response.body).to include('Welcome to the Sample App!')
    end
  end

  describe 'GET /login' do
    it 'login with valid information' do
      user = create(:user)
      get login_path
      post login_path, params: { session: attributes_for(:user) }
      expect(response).to redirect_to(user)
      follow_redirect!

      expect(response).to render_template(:show)
      expect(session[:user_id]).to be
    end
  end
end
