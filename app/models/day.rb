class Day < ApplicationRecord
  belongs_to :user
  has_many :workout_sets, dependent: :destroy
  validates :occurred_on, presence: true
  validate :occurred_on_must_be_valid_date

 private

  def occurred_on_must_be_valid_date
   if occurred_on_before_type_cast.present? && occurred_on.nil?
     errors.add(:occurred_on, "は存在する日付を入力してください")
   end
  end
end
