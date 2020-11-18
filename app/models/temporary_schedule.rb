class TemporarySchedule
  include ActiveModel::Model

  attr_accessor :destination_name, :destination_lat_lng, :destination_address, :current_location

  validates :destination_name, presence: true
  # validates :destination_lat_lng, presence: true
  # validates :destination_address, presence: true

  def adjust_latlng(lat_lng)
    lat, lng = lat_lng.delete("()").split(/,/)
    return lat.to_f, lng.to_f
  end
end
