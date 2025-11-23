class Exercise < ApplicationRecord
  belongs_to :target, optional: false
  belongs_to :created_by_user, class_name: "User", optional: true
  has_many :workout_sets, dependent: :destroy

  validates :name,
            presence: true,
            uniqueness: { scope: [ :created_by_user_id, :target_id ] },
            length: { maximum: 50 }
  validate  :not_duplicate_with_default
  validate  :created_by_user_or_default
  # デフォルトのレコードのみ抽出するメソッドを定義
  scope :default, -> { where(is_default: true) }

  private
  # ターゲット・エクササイズ名共にデフォルトのエクササイズと重複してたらエラー
  def not_duplicate_with_default
    if created_by_user_id.present? && Exercise.default.exists?(name: name, target_id: target_id)
      errors.add(:name, "はデフォルトのエクササイズと重複しています")
    end
  end
  def created_by_user_or_default
    if created_by_user.blank? && !is_default
      errors.add(:base, "作成者かデフォルトのいずれかが必要です")
    end
  end
end
