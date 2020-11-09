class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
    @google_maps_api_key = Rails.application.credentials.api_key[:google_maps]
  end

  def create
    schedule_params_kai = schedule_params
    # binding.pry
    lat, lng = params[:schedule][:destination_lat_lng].delete("()").split(/,/)
    schedule_params_kai[:destination_lat] = lat.to_f
    schedule_params_kai[:destination_lng] = lng.to_f
    # schedule_params_kai << { destination_lng: lng.to_f }
    @schedule = current_user.schedules.new(schedule_params_kai)
    if @schedule.save
      binding.pry
      redirect_to schedules_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def schedule_params
    params.require(:schedule).permit(:name, :meeting_time, :destination_name, :destination_address, :description, :user_id)
  end
end
