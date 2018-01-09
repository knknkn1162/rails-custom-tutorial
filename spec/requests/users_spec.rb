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
    it 'submit users with ' do
      get signup_path
      expect(response).to have_http_status(200)
      expect { post users_path, params: { user: invalid_user } }.to change(User, :count).by(0)
      expect(response).to render_template(:new)
    end
  end
end
