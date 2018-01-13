require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
