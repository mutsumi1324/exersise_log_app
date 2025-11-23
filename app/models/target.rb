class Target < ApplicationRecord
  has_many :exercises, dependent: :destroy
  belongs_to :created_by_user, class_name: "User", optional: true
  validates :name,
            presence: true,
            uniqueness: { scope: [ :created_by_user_id ] },
            length: { maximum: 25, message: "は25文字以内で入力してください" }
  validate :not_duplicate_with_default, :created_by_user_or_default
  scope :default, -> { where(is_default: true) }

  private
  def not_duplicate_with_default
    if  Target.default.exists?(name: name)
      errors.add(:name, "はデフォルトのエクササイズと重複しています")
    end
  end
  def created_by_user_or_default
    if created_by_user_id && is_default
      errors.add(:base, "作成者とデフォルトは共存できません")
    end
    if created_by_user_id.blank? && !is_default
      errors.add(:base, "作成者かデフォルトのいずれかが必須です")
    end
  end
end
