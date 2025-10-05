class Exercise < ApplicationRecord
  belongs_to :target, optional: false
  belongs_to :created_by_user, class_name: "User", optional: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: :created_by_user_id }
  validate  :not_duplicate_with_default
  # デフォルトのレコードのみ抽出するメソッドを定義
  scope :default, -> { where(is_default: true) }

  private
  # ターゲット・エクササイズ名共にデフォルトのエクササイズと重複してたらエラー
  def not_duplicate_with_default
    if created_by_user_id.present? && Exercise.default.exists?(name: name, target_id: target_id)
      errors.add(:name, "はデフォルトのエクササイズと重複しています")
    end
  end
end
