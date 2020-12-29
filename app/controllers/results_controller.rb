class ResultsController < ApplicationController
  def show
    @schedule = current_user.schedules.find(params[:id])
    # Jsに渡す変数
    gon.latlng = [[@schedule.destination_lat,@schedule.destination_lng],[@schedule.start_point_lat,@schedule.start_point_lng]]
    gon.excuse = @schedule.excuse_schedules.map do |excuse_schedule|
      Excuse.find(excuse_schedule.excuse_id)
    end
  end
end
