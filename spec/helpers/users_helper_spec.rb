require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  describe 'users helper' do
    it 'has correct return_value for gravatar_for' do
      sample_email = 'sample@gmail.com'
      user = build(:user, email: sample_email)
      id = Digest::MD5::hexdigest(sample_email)
      expect(helper.gravatar_for(user)).to include 'https://secure.gravatar.com/avatar/acb479080840025a9c03f8453f5c853c?s=80'
    end
  end
end
