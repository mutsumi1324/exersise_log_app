class WorkoutSet < ApplicationRecord
  belongs_to :day
  belongs_to :exercise

  validates :weight,
              format: {
                with: /\A\d{1,3}(\.\d{1,2})?\z/,
                message: "は整数または小数第2位まで入力してください"
              },
              allow_nil: true
  validates :reps,
              numericality: {
                only_integer: true,
                greater_than: 0,
                less_than_or_equal_to: 100,
                message: "は1以上100以下の数字で入力してください"
              },
              allow_nil: true
  validates :memo,
              length: {
                in: 1..255,
                message: "は1字以上255文字以下で入力してください"
              },
              allow_nil: true
  before_validation :nomalize_blank_values, :if_blank_destroy

  private
  def nomalize_blank_values
    self.weight = nil if weight.blank?
    self.reps = nil if reps.blank?
    self.memo = nil if memo.blank?
  end
end
