FactoryBot.define do
  factory :user, aliases: [ :created_by_user ] do
    name { "山田太郎" }
    sequence(:email) { |n|"user#{n}@example.com" }
    password { "Password@1" }
    password_confirmation { "Password@1" }
  end
end
