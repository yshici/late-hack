class Excuse < ApplicationRecord
  validates :content, length: { maximum: 255 }

  has_many :excuse_schedules
  has_many :schedules, through: :excuse_schedules
end
