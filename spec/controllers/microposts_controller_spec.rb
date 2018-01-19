require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do

  describe "POST #create" do
    it "should redirect create when not logged in" do
      expect {
        post :create, params: { micropost: {
          content: 'Lorem ipsum'
        } }
      }.to change(Micropost, :count).by(0)
      expect(response).to redirect_to('/login')
    end
  end

  describe "DELETE #destroy" do
    it "should redirect destroy when not logged in" do
      micropost = create(:micropost)
      expect {
        delete :destroy, params: { id: micropost.id }
      }.to change(Micropost, :count).by(0)

      expect(response).to redirect_to('/login')
    end
  end
end
