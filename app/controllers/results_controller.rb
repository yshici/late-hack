class ResultsController < ApplicationController
  def show
    @schedule = current_user.schedules.find(params[:id])
  end
end
