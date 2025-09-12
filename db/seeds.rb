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
  { name: "hogehoge", email: "hogehoge@example.com", password: "Password@1", password_confirmation: "Password1", height: "170", body_weight: "64.5" }
]

users.each do |user|
  User.find_or_create_by!(email: user[:email]) do |u|
    u.name = user[:name]
    u.password = user[:password]
    u.password_confirmation = user[:pasword_confirmation]
    u.height = user[:height]
    u.body_weight = user[:body_weight]
  end
end

body_parts = [
  { name: "胸" },
  { name: "背中" },
  { name: "脚" },
  { name: "肩" },
  { name: "腕" }
]

body_parts.each do |body_part|
  BodyPart.find_or_create_by!(name: body_part[:name])
end

exercises = [
  { name: "ベンチプレス", body_part_id: BodyPart.find_by(name: "胸").id, is_default: true },
  { name: "スクワット", body_part_id: BodyPart.find_by(name: "脚").id, is_default: true },
  { name: "デッドリフト", body_part_id: BodyPart.find_by(name: "背中").id, is_default: true }
]

exercises.each do |exercise|
  Exercise.find_or_create_by!(name: exercise[:name], body_part_id: exercise[:body_part_id]) do |e|
    e.is_default = true
  end
end
