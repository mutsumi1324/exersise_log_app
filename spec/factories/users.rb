FactoryBot.define do
  factory :user, aliases: [ :create_by_user ] do
    name { "山田太郎" }
    email { "tarou@example.com" }
    password { "Password@1" }
    password_confirmation { "Password@1" }
  end
end
