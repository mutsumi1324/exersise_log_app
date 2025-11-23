class UserMetric < ApplicationRecord
  belongs_to :user
  validates :height, numericality: {
     only_integer: true, greater_than: 100, less_than: 300,
     message: "は101〜299までの整数で入力してください"
    }
  validates :body_weight,
    numericality: {
      greater_than: 20, less_than: 400,
      message: "は20.01〜399.99までで入力してください"
    }
  validate :body_weight_format

  private
  def body_weight_format
    value = body_weight_before_type_cast
    return if value.blank?

    unless value.to_s.match?(/\A\d+(\.\d{1,2})?\z/)
      errors.add(:body_weight, "は小数点第二位までで入力してください")
    end
  end
end
