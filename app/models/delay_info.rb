class DelayInfo
  include ActiveModel::Model

  attr_accessor :name, :destination, :longitude_latitude, :current_location, :meeting_time

  validates :name, presence: true
  validates :destination, presence: true
  validates :longitude_latitude, presence: true
  # validates :current_location, presence: true
  validates :meeting_time, presence: true
  end
