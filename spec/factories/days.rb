FactoryBot.define do
  factory :day do
    association :user
    occurred_on { Date.today }
  end
end
