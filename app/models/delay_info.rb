class DelayInfo
  include ActiveModel::Model

  attr_accessor :name, :destination, :lat_lng, :current_location, :meeting_time

  validates :name, presence: true
  validates :destination, presence: true
  validates :lat_lng, presence: true
  # validates :current_location, presence: true
  validates :meeting_time, presence: true
  end
