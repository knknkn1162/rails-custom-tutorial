FactoryBot.define do
  factory :user do
    name 'Example User'
    email 'user@example.com'
    password 'foobar'
    password_confirmation 'foobar'
    admin true

    factory :other do
      name 'Other User'
      email 'other@example.co.jp'
      admin false
    end
  end
end
