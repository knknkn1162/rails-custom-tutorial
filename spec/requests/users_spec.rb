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

  describe "POST /signup" do
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

  describe 'POST /login' do
    it 'login with valid information followed by logout' do
      user = create(:user)
      get login_path
      post login_path, params: { session: attributes_for(:user) }
      expect(response).to redirect_to(user)
      follow_redirect!

      expect(response).to render_template(:show)
      expect(session[:user_id]).to be

      delete logout_path
      expect(session[:user_id]).not_to be
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'POST /edit' do
    it 'unsuccessful edit' do
      user = create(:user)
      # login in advance
      post login_path, params: { session: attributes_for(:user) }
      get edit_user_path(user)

      patch user_path(user), params: { user: invalid_user }
      expect(response).to render_template(:edit)
      expect(response.body).to include('4 errors')
    end

    it 'successful edit' do
      user = create(:user)
      # login in advance
      post login_path, params: { session: attributes_for(:user) }

      get edit_user_path(user)
      name = 'Foo Bar'
      email = 'foo@bar.com'
      patch user_path(user), params: {
        user: {
          name: name,
          email: email,
          password: '',
          password_confirmation: ''
        }
      }
      expect(flash[:success]).to be
      expect(response).to redirect_to(user_url(user))

      user.reload
      expect([user.name, user.email]).to eq [name, email]
    end
  end
end
