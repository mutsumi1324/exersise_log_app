class BodyPart < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
