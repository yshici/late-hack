class TemporarySchedulesController < ApplicationController
  skip_before_action :require_login
  def new
    @schedule = TemporarySchedule.new
  end

  def create
    session[:schedule] = TemporarySchedule.new(schedule_params)
    redirect_to temporary_schedules_path
  end

  def show
    @schedule = session[:schedule]
    lat, lng = TemporarySchedule.new().adjust_latlng(@schedule["destination_lat_lng"])
    @api_info = ApiGet.new().get_api.merge(ApiGet.new().get_api_with_position(lat, lng))
  end

private

  def schedule_params
    params.require(:temporary_schedule).permit(:destination_name, :destination_lat_lng, :destination_address)
  end
end
