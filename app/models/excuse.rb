class Excuse < ApplicationRecord
  validates :content, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :late_time, presence: true

  has_many :excuse_schedules
  has_many :schedules, through: :excuse_schedules
end
