FactoryBot.define do
  factory :user_metric do
    association :user
    height { 170 }
    body_weight { 64.55 }
  end
end
