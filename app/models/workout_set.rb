class WorkoutSet < ApplicationRecord
  belongs_to :day
  belongs_to :exercise

  validates :weight,
              numericality: {
                allow_nil: true,
                less_than: 500,
                greater_than: -150,
                message: "は-149.99〜499.99以下の数字で入力してください"
              }
  validate  :weight_format

  validates :reps,
              numericality: {
                greater_than: 0,
                less_than_or_equal_to: 100,
                message: "は1〜100までの整数で入力してください"
              },
              allow_nil: true
  validates :reps,
              numericality: {
                allow_nil: true,
                only_integer: true,
                message: "は整数で入力してください"
              }

  validates :memo,
              length: {
                in: 1..255,
                message: "は1字以上255文字以下で入力してください"
              },
              allow_nil: true

  validates :set_number,
              presence: true,
              numericality: {
                greater_than_or_equal_to: 1,
                less_than_or_equal_to: 10
              },
              uniqueness: { scope: [ :day_id, :exercise_id ] }

  before_validation :nomalize_blank_values
  after_save :if_blank_destroy
  private
  def nomalize_blank_values
    self.weight = nil if weight.blank?
    self.reps = nil if reps.blank?
    self.memo = nil if memo.blank?
  end

  def if_blank_destroy
    if weight.nil? && reps.nil? && memo.nil?
      destroy
    end
    if day.workout_sets.reload.blank?
      day.destroy
    end
  end

  def weight_format
    value = weight_before_type_cast
    return if value.blank?

    unless value.to_s.match?(/\A-?\d+(\.\d{1,2})?\z/)
      errors.add(:weight, "は小数点第二位までで入力してください")
    end
  end
end
