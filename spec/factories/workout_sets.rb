FactoryBot.define do
  factory :workout_set do
    association :day
    association :exercise
    weight { 10.25 }
    reps { 10 }
    memo { "最後にバランスを崩した" }
  end
end
