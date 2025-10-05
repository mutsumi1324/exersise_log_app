FactoryBot.define do
  factory :exercise do
    association :target
    name { "バーティカルジャンプ" }
  end
end
