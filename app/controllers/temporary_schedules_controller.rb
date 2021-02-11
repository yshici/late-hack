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
    # 言い訳をランダムで3つ取ってくる
    @select_excuses = Excuse.find(Excuse.pluck(:id).shuffle[0..2])
    gon.excuse = @select_excuses
    # 遅刻時間の合計算出して時間・分に変換
    late_times = 0
    @select_excuses.each do |select_excuse|
      late_times += select_excuse.late_time
    end
    @late_time = Time.at(late_times*60).utc.strftime('%-H時間%-M分')
    gon.late_time = @late_time
  end

  private

  def schedule_params
    params.require(:temporary_schedule).permit(:destination_name, :destination_lat_lng, :destination_address, :start_point_name, :start_point_lat_lng, :start_point_address)
  end
end
