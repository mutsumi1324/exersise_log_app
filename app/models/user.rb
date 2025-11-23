class User < ApplicationRecord
  has_many :days, dependent: :destroy
  has_many :exercises, foreign_key: :created_by_user_id, dependent: :destroy
  has_many :target, foreign_key: :created_by_user_id
  has_many :user_metrics, dependent: :destroy
  has_secure_password validations: false
  validates :password, presence: true,
  format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()+\\\/\-])[a-zA-Z\d_!@#$%^&*()+\\\/\-]{8,15}\z/,
    message: "は半角英字（大文字・小文字を含む）・半角数字・記号を含む8〜15文字で入力してください"
   }
  validates :password_confirmation, presence: true
  validates :name, presence: true,
  format: {
    with: /\A[\p{Hiragana}\p{Katakana}\p{Han}a-zA-Z0-9_]{2,20}\z/,
    message: "は2〜20文字のひらがな・カタカナ・漢字・アルファベットいずれかで入力してください"
   }
  validates :email,  presence: true,
  format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: "は存在するアドレスのフォーマットで入力してください" }

  before_validation :password_confirmation_unmatch
  private
  def password_confirmation_unmatch
    if password && password_confirmation && password != password_confirmation
      errors.add(:base, "確認用パスワードが一致しません")
    end
  end
end
