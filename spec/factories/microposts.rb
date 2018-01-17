FactoryBot.define do
  factory :micropost do
    content 'MyText'
    created_at { Time.zone.now }

    factory :orange do
      content 'I ate an orange'
      created_at { 10.minutes.ago }
    end

    factory :tau do
      content 'Check out the tau'
      created_at { 3.years.ago }
    end
  end
end
