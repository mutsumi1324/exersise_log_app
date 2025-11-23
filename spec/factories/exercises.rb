FactoryBot.define do
  factory :exercise do
    association :created_by_user
    association :target
    name { "カーフレイズ" }
  end
end
