class Day < ApplicationRecord
  belongs_to :user
  has_many :workout_sets
  validates :occurred_on, presence: true
  validate :occurred_on_must_be_valid_date

 private

  def occurred_on_must_be_valid_date
    return if occurred_on.blank?
    begin
      Date.parse(occurred_on.to_s)
    rescue ArgumentError
      errors.add(:occurred_on, "は存在する日付を入力してください")
    end
  end
end
