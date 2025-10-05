# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = [
  { name: "hogehoge", email: "hogehoge@example.com", password: "Password@1", password_confirmation: "Password@1" }
]

users.each do |user|
  User.find_or_create_by!(email: user[:email]) do |u|
    u.name = user[:name]
    u.password = user[:password]
    u.password_confirmation = user[:password_confirmation]
  end
end

targets = [
  { name: "胸" },
  { name: "背中" },
  { name: "脚" },
  { name: "肩" },
  { name: "腕" }
]

targets.each do |target|
  Target.find_or_create_by!(name: target[:name])
end

exercises = [
  { name: "ベンチプレス", target_id: Target.find_by(name: "胸").id, is_default: true },
  { name: "スクワット", target_id: Target.find_by(name: "脚").id, is_default: true },
  { name: "デッドリフト", target_id: Target.find_by(name: "背中").id, is_default: true },
  { name: "チンニング", target_id: Target.find_by(name: "背中").id, is_default: true },
  { name: "ルーマニアンデッドリフト", target_id: Target.find_by(name: "背中").id, is_default: true },
  { name: "ショルダープレス", target_id: Target.find_by(name: "肩").id, is_default: true }
]

exercises.each do |exercise|
  Exercise.find_or_create_by!(name: exercise[:name], target_id: exercise[:target_id]) do |e|
    e.is_default = exercise[:is_default]
  end
end
