require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  let(:root_with_log_in) {
    user = create(:user_with_posts)
    post login_path, params: { session: attributes_for(:user) }
    user
  }

  describe 'POST /microposts' do
    it 'should raise error when invalid post' do
      user = root_with_log_in
      expect {
        post microposts_path, params: { micropost: { content: '' } }
      }.to change(user.microposts, :count).by(0)
      # NOT redirect
      expect(response.body).to include 'error'
    end

    it 'should redirect to root with valid url' do
      user = root_with_log_in
      content = 'content sample'
      expect {
        post microposts_path, params: { micropost: { content: content } }
      }.to change(user.microposts, :count).by(1)

      expect(response).to redirect_to(root_url)

      follow_redirect!
      expect(response.body).to include content
    end
  end
  describe 'DELETE /microposts' do
    it 'should redirect destroy for wrong micropost' do
      user_with_posts = create(:user_with_posts)
      create(:other)
      # log in as other user
      post login_path, params: { session: attributes_for(:other) }
      expect {
        delete micropost_path(user_with_posts.microposts[0])
      }.to change(user_with_posts.microposts, :count).by(0)
      expect(response).to redirect_to(root_url)
    end

    it 'should delete micropost' do
      user = root_with_log_in
      first_micropost = user.microposts.paginate(page: 1).first

      expect {
        delete micropost_path(first_micropost)
      }.to change(user.microposts, :count).by(-1)

      expect(response).to redirect_to(root_url)
    end
  end
end
