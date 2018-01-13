require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe 'sessions helper' do
    it 'works current_user when log_in' do
      user = create(:user)
      helper.log_in(user)
      expect(session[:user_id]).to eq user.id
      # include helper module
      expect(helper.cookies.signed[:user_id]).not_to be
      expect(helper.get_current_user).to eq user

      helper.log_out
      expect(session[:user_id]).not_to be
      expect(helper.cookies.signed[:user_id]).not_to be
    end

    it 'works current_user when remember_me' do
      user = create(:user)
      helper.remember(user)
      expect(helper.get_current_user).to eq user
      expect(session[:user_id]).to eq user.id
      expect(helper.cookies.signed[:user_id]).to be user.id

      helper.forget(user)
      expect(session[:user_id]).to be user.id
      expect(helper.cookies.signed[:user_id]).not_to be
    end

    it 'not works current_user when changing remember_digest' do
      user = create(:user)
      helper.remember(user)
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(helper.get_current_user).not_to be
    end
  end
end
