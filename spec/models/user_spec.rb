require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
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

    it 'should have password present(nonblank) ' do
      sample_pwd = ' ' * 6
      user = build(:user, password: sample_pwd, password_confirmation: sample_pwd)
      expect(user).not_to be_valid
    end

    it 'should have password with a minimum length' do
      sample_pwd = 'a' * 5
      user = build(:user, password: sample_pwd, password_confirmation: sample_pwd)
      expect(user).not_to be_valid
    end
  end
  context 'user method test' do
    it 'works authenticated method' do
      user = build(:user)
      expect(user.authenticated?(:remember, '')).not_to be
    end
  end

  context 'user association test' do
    it 'destroys all posts associated with user' do
      user = create(:user) do |user|
        user.microposts.create(attributes_for(:micropost))
      end

      expect{user.destroy}.to change(user.microposts, :count).by(-1)
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
