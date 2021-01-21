class ResultsController < ApplicationController
  def show
    @schedule = current_user.schedules.find(params[:id])
    # Jsに渡す変数
    gon.latlng = [[@schedule.destination_lat,@schedule.destination_lng],[@schedule.start_point_lat,@schedule.start_point_lng]]
    select_excuses = @schedule.excuse_schedules.map do |excuse_schedule|
      Excuse.find(excuse_schedule.excuse_id)
    end
    gon.excuse = select_excuses
    # 遅刻時間の合計算出して時間・分に変換
    late_times = 0
    select_excuses.each do |select_excuse|
      late_times += select_excuse.late_time
    end
    @late_time = Time.at(late_times*60).utc.strftime('%-H時間%-M分')
  end
end
