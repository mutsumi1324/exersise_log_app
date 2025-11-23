FactoryBot.define do
  factory :target do
    name { "ふくらはぎ" }
    association :created_by_user
  end
end
