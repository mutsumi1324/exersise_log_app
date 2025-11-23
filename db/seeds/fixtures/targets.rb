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
