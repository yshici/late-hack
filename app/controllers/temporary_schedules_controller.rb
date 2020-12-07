class TemporarySchedulesController < ApplicationController
  skip_before_action :require_login
  def new
    @schedule = TemporarySchedule.new
  end

  def create
    @schedule = TemporarySchedule.new(schedule_params)
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
    @latlng = []
    @latlng << TemporarySchedule.new().adjust_latlng(@schedule["destination_lat_lng"])
    @latlng << TemporarySchedule.new().adjust_latlng(@schedule["start_point_lat_lng"])
    gon.latlng = @latlng
    @api_info = ApiGet.new().get_api.merge(ApiGet.new().get_api_with_position(@latlng[0][0], @latlng[0][1]))
    gon.excuse = ExcuseForLate.new().excuse
  end

  private

  def schedule_params
    params.require(:temporary_schedule).permit(:destination_name, :destination_lat_lng, :destination_address, :start_point_name, :start_point_lat_lng, :start_point_address)
  end
end
