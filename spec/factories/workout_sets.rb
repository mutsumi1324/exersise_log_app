FactoryBot.define do
  factory :workout_set do
    transient do
      user { create(:user) }
    end

    exercise { create(:exercise, created_by_user: user) }
    day      { create(:day, user: user) }

    weight { 10.25 }
    reps { 10 }
    memo { "最後にバランスを崩した" }
    set_number { 1 }
  end
end
