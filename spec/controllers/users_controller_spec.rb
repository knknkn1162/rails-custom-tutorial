require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  subject(:invalid_user) {
    {
        name: '',
        email: 'foo@invalid',
        password: 'foo',
        password_confirmation: 'bar'
    }
  }

  describe 'GET #index' do
    it 'returns successful redirection' do
      get :index
      expect(response).to redirect_to('/login')
    end
  end

  describe "GET #signup" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET #edit' do
    it 'redirects edit when not logged in' do
      user = create(:user)
      # NOT exec log_in_as(...)
      get :edit, params: { id: user.id }
      expect(flash[:danger]).to be
      expect(response).to redirect_to('/login')
    end
  end

  describe "POST /signup" do
    it 'submit with invalid users' do
      expect {
        post :create, params: { user: invalid_user }
      }.to change(User, :count).by(0)
      expect(response).to render_template(:new)
    end
  end

  describe 'PATCH #update' do
    it 'redirects update when not logged in' do
      user = create(:user)
      # NOT exec log_in_as(...)
      patch :update, params: { user: attributes_for(:user), id: user.id }
      expect(flash[:danger]).to be
      expect(response).to redirect_to('/login')
    end
  end
end
