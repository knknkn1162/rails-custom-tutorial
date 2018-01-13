FactoryBot.define do
  factory :user do
    name 'Example User'
    email 'user@example.com'
    password 'foobar'
    password_confirmation 'foobar'

    factory :other do
      name 'Other User'
      email 'other@example.co.jp'
    end
  end
end
