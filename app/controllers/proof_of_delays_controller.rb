class ProofOfDelaysController < ApplicationController
  skip_before_action :require_login
  def new
    @delay_info = DelayInfo.new
    @google_maps_api_key = Rails.application.credentials.api_key[:google_maps]
  end

  def create
    delay_info = DelayInfo.new(schedule_params)
    session[:delay_info] = delay_info
    redirect_to proof_of_delays_path
  end

  def show
    @delay_info = session[:delay_info]
    lat, lng = @delay_info["destination_lat_lng"].delete("()").split(/,/)
    lat = lat.to_f
    lng = lng.to_f
    @weather = ApiGet.new().weather(lat, lng)
    @name_train_delay = ApiGet.new().train
    @get_nhk = ApiGet.new().nhk
    @get_restaurnt = ApiGet.new().restaurant(lat, lng)
    @get_hotel = ApiGet.new().hotel(lat, lng)
  end

private

  def schedule_params
    params.require(:delay_info).permit(:name, :destination_name, :destination_lat_lng, :destination_address, :current_location, :meeting_time)
  end
end

