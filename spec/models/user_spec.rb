require 'rails_helper'

RSpec.describe User, type: :model do
  context ':user should be valid' do
    it 'shold be valid' do
      user = build(:user)
      expect(user).to be_valid
    end
    
    it 'name should be present' do
      user = build(:user, name: ' ')
      expect(user).not_to be_valid
    end

    it 'email validation should accept valid address' do
      valid_addresses = %w[
        user@example.com
        USER@foo.COM
        A_US-ER@foo.bar.org
        first.last@foo.jp
        alice+bob@baz.cn
      ]
      valid_addresses.each do |valid_address|
        user = build(:user, email: valid_address)
        expect(user).to be_valid
      end
    end

    it 'email validation should reject invalid address' do
      invalid_addresses = %w[
        user@example,com
        user_at_foo.org
        user.name@exapmple.foo@bar_baz.com
        foo@bar+baz.com
      ]
      invalid_addresses.each do |invalid_address|
        user = build(:user, email: invalid_address)
        expect(user).not_to be_valid
      end
    end
  end
  context 'callback test' do
    let(:user) { create(:user, email: 'Foo@ExAmPle.CoM') }
    it 'email addresses sholdb be saved as lower-case' do
      expect(user).to callback(:downcase_email).before(:save)
      expect(user.email).to eq('foo@example.com')
    end
  end
end
