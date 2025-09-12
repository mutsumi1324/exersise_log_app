class Exercise < ApplicationRecord
  belongs_to :body_part, optional: false
  belongs_to :created_by_user, class_name: "User", optional: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: :created_by_user_id }
  validate  :not_duplicate_with_default
  scope :default, -> { where(is_default: true) }

  private

  def not_duplicate_with_default
    if created_by_user_id.present? && Exercise.default.exists?(name: name)
      errors.add(:name, "はデフォルトのエクササイズと重複しています")
    end
  end
end
