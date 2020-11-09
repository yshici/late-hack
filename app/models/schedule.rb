# schema.rb
# create_table "schedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
#     t.string "name"
#     t.datetime "meeting_time"
#     t.string "destination_name"
#     t.string "destination_address"
#     t.float "destination_lat"
#     t.float "destination_lng"
#     t.text "description"
#     t.integer "user_id"
#     t.datetime "created_at", precision: 6, null: false
#     t.datetime "updated_at", precision: 6, null: false
#   end

class Schedule < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :meeting_time, presence: true
  validates :destination_name, presence: true, length: { maximum: 255 }
  validates :destination_address, presence: true, length: { maximum: 255 }
  validates :destination_lat, presence: true
  validates :destination_lng, presence: true
  validates :description, length: { maximum: 1000 }

  belongs_to :user
end
