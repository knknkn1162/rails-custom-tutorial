require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #signup" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  it 'GET #edit' do
    user = create(:user)
    get :edit, params: { id: user.id }
    expect(response).to have_http_status(:success)
    expect(assigns(:user)).to eq user
    expect(response).to render_template(:edit)
  end
end
