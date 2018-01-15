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
    # accompany with redirect
    it 'submit with valid users' do
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

  describe 'PATCH /update' do
    it 'should redirect edit when logged in as wrong user' do
      other = create(:other)
      user = create(:user)
      # log in as other user in advance
      post login_path, params: { session: attributes_for(:user) }

      patch user_path(other), params: { user: attributes_for(:user) }

      expect(flash).to be
      expect(response).to redirect_to(root_url)
    end

    it 'should redirect update when logged in as wrong user' do
      other = create(:other)
      user = create(:user)
      post login_path, params: { session: attributes_for(:user) }

      patch user_path(other), params: { user: attributes_for(:user) }

      expect(flash).to be
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

    it 'should not allow the admin attribute to be edited via the web' do
      other = create(:other)
      expect(other.admin?).to be false
      post login_path, params: { session: attributes_for(:other) }

      # check malicious admin change
      patch user_path(other), params: { user: {
        password: 'foobar',
        password_confirmation: 'foobar',
        admin: true
      } }

      other.reload
      expect(other.admin?).to be false
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

    it 'successful edit with friendly forwarding' do
      user = create(:user)

      # first edit_user_path and then login
      get edit_user_path(user)
      # remember accessing url
      expect(session[:forwarding_url]).to eq edit_user_url(user)

      post login_path, params: { session: attributes_for(:user) }
      expect(response).to redirect_to(edit_user_url(user))
    end
  end

  describe 'DELETE /edit' do
    it 'should redirect destroy when logged in as a non-admin' do
      create(:other)
      user = create(:user)

      post login_path, params: { session: attributes_for(:other) }
      expect {
        delete user_path(user)
      }.to change(User, :count).by(0)
      expect(response).to redirect_to(root_url)
    end

    it 'should delete designated user when logout_path' do
      other = create(:other)
      create(:user)

      post login_path, params: { session: attributes_for(:user) }
      expect {
        delete user_path(other)
      }.to change(User, :count).by(-1)

      expect(response).to redirect_to(users_path)
    end
  end
end
