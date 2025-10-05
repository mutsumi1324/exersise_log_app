class UserMetric < ApplicationRecord
  belongs_to :user
  validates :height, numericality: {
     only_integer: true, greater_than: 0, less_than: 300,
     message: "は1〜299までの整数で入力してください"
    }
  validate :body_weight_format

  private
  def body_weight_format
    value = body_weight_before_type_cast
    return if value.blank?
    unless value.to_s.match?(/\A\d{1,3}(\.\d{1,2})?\z/)
      errors.add(:body_weight, "は0.01〜999.99までの整数または小数第2位までで入力してください")
    end
  end
end
