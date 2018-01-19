require 'rails_helper'

RSpec.describe Relationship, type: :model do
  context 'user validation test' do
    it 'should be valid' do
      relationship = build(:relationship)
      expect(relationship).to be_valid
    end

    it 'should require a follower id' do
      relationship = build(:relationship, follower_id: nil)
      expect(relationship).not_to be_valid
    end

    it 'should require a followed id' do
      relationship = build(:relationship, followed_id: nil)
      expect(relationship).not_to be_valid
    end
  end
end
