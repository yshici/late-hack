class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
    @google_maps_api_key = Rails.application.credentials.api_key[:google_maps]
  end

  def create
    redirect_to schedules_path
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
