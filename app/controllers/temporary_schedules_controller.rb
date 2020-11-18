class TemporarySchedulesController < ApplicationController
  skip_before_action :require_login
  def new
    @schedule = TemporarySchedule.new
  end

  def create
    @schedule = TemporarySchedule.new(schedule_params)
    # binding.pry
    if @schedule.valid?
      session[:schedule] = @schedule
      redirect_to temporary_schedules_path
    else
      flash.now[:danger] = '待ち合わせ場所が入力できていません'
      render action: :new
    end
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
