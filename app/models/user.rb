class User < ApplicationRecord
  has_many :days
  has_many :workout_sets, through: :days
  has_secure_password
  validates :password, length: { minimum: 8, maximum: 15 },
  format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()+\\\/\-])[a-zA-Z\d_!@#$%^&*()+\\\/\-]{8,15}\z/,
    message: "が不正です"
   }
  validates :name, presence: true,
  format: {
    with: /\A[\p{Hiragana}\p{Katakana}\p{Han}a-zA-Z0-9_]{2,20}\z/,
    message: "が不正です"
   }
  validates :email,  presence: true,
  format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: "が不正です" }
  validates :height, numericality: {
     only_integer: true, greater_than: 0, less_than: 300,
     message: "は1〜299までの整数で入力してください"
    }
  validates :body_weight,
  format: {
     with: /\A\d{1,3}(\.\d{1,2})?\z/,
     message: "は整数または小数第2位まで入力してください"
     }
end
