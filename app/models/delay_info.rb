class DelayInfo
  include ActiveModel::Model

  attr_accessor :name, :destination_name, :destination_lat_lng, :destination_address, :current_location, :meeting_time

  validates :name, presence: true
  validates :destination_name, presence: true
  validates :destination_lat_lng, presence: true
  validates :destination_address, presence: true
  # validates :current_location, presence: true
  validates :meeting_time, presence: true
  end
