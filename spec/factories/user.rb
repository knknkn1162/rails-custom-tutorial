FactoryBot.define do
  factory :user do
    name 'Example User'
    email 'user@example.com'
    password 'foobar'
    password_confirmation 'foobar'
    admin true
    activated true
    activated_at Time.zone.now

    factory :user_with_posts do
      after(:create) do |u, evalator|
        create_list(:micropost, 35, user: u)
      end
    end
    factory :other do
      name 'Other User'
      email 'other@example.co.jp'
      admin false
      activated true
      activated_at Time.zone.now
    end
  end
end
