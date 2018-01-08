require 'rails_helper'

RSpec.describe User, type: :model do
  context ':user should be valid' do
    it 'shold be valid' do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end
