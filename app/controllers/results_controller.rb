class ResultsController < ApplicationController
  def show
    @schedule = current_user.schedules.find(params[:id])
    # Jsに渡す変数s
    gon.latlng = [[@schedule.destination_lat,@schedule.destination_lng],[@schedule.start_point_lat,@schedule.start_point_lng]]
    gon.excuse = ExcuseForLate.new().excuse
  end
end
