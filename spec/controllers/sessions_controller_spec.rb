require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it 'login with invalid user' do
      user = create(:user)
      post :create, params: { session: {
        email: user.email,
        password: user.password + 'a'
      } }

      expect(response).to render_template(:new)
    end

    it "login with valid user and remember_me check" do
      user = create(:user)
      post :create, params: { session: {
        email: user.email,
        password: user.password,
        remember_me: '1',
      }}
      expect(assigns(:user).remember_token).to be
      expect(response.cookies["remember_token"]).to be
      expect(response).to redirect_to(user_path(user))
    end

    it 'login with valid user and NOT check remember_me' do
      user = create(:user)
      post :create, params: { session: {
        email: user.email,
        password: user.password,
        remember_me: '0',
      }}

      expect(assigns(:user).remember_token).not_to be
      expect(response.cookies["remember_token"]).not_to be
      expect(response).to redirect_to(user_path(user))
    end
  end
end
