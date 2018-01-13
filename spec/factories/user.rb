FactoryBot.define do
  factory :user do
    name 'Example User'
    email 'user@example.com'
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :other do
    name 'Other User'
    email 'other@example.co.jp'
    password 'foobar'
    password_confirmation 'foobar'
  end
end
