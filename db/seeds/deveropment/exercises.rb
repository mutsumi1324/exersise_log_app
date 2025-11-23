exercises = [
  { name: "ベンチプレス", target_id: Target.find_by(name: "胸").id, is_default: true },
  { name: "スクワット", target_id: Target.find_by(name: "脚").id, is_default: true }
]

exercises.each do |exercise|
  Exercise.find_or_create_by!(name: exercise[:name], target_id: exercise[:target_id]) do |e|
    e.is_default = exercise[:is_default]
  end
end
