targets = [
  { name: "胸" },
   { name: "脚" }
  ]

targets.each do |target|
  Target.find_or_create_by!(name: target[:name])
end
