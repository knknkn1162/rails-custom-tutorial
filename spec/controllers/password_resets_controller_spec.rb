require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  before :each do
    ActionMailer::Base.deliveries.clear
  end

  describe "GET #new" do
    it 'renders password_resets/new' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it 'doesnt work when the email is invalid' do
      post :create, params: { password_reset: { email: ''} }
      expect(flash).not_to be_empty
      expect(response).to render_template(:new)
    end

    it 'works when the the email is valid' do
      user = create(:user)
      post :create, params: { password_reset: {email: user.email } }
      old_reset_digest = user.reset_digest
      user.reload
      expect(old_reset_digest).not_to eq user.reset_digest
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(flash).not_to be_empty
      expect(response).to redirect_to(root_url)
    end
  end
end
