require 'rails_helper'

RSpec.describe Micropost, type: :model do
  context 'validation test' do
    it 'shold be valid' do
      user = build_stubbed(:user)
      micropost = user.microposts.build(content: 'Lorem ipsum')
      expect(micropost).to be_valid
    end

    it 'user_id should be present' do
      user = build_stubbed(:user)
      micropost = user.microposts.build(user_id: nil)
      expect(micropost).not_to be_valid
    end

    it 'should have non-empty content' do
      user = build_stubbed(:user)
      micropost = user.microposts.build(content: ' ')
      expect(micropost).not_to be_valid
    end

    it 'should have content less than or equal 140 characters' do
      user = build_stubbed(:user)
      micropost = user.microposts.build(content: 'a'*141)
      expect(micropost).not_to be_valid
    end
  end
end
