class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[show edit update destroy]

  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
    @google_maps_api_key = Rails.application.credentials.api_key[:google_maps]
  end

  def create
    @schedule = current_user.schedules.new(adjust_schedule_params)
    if @schedule.save
      redirect_to schedules_path, success: 'スケジュールを登録しました'
    else
      flash.now[:danger] = 'スケジュール登録できませんでした'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @schedule.update(adjust_schedule_params)
      redirect_to schedules_path, success: 'スケジュールを更新しました'
    else
      lash.now[:danger] = 'スケジュール更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @schedule.destroy!
    redirect_to schedules_path, success: 'スケジュールを削除しました'
  end

  def set_schedule
    @schedule = current_user.schedules.find(params[:id])
  end

  private

  def schedule_params
    params.require(:schedule).permit(:name, :meeting_time, :destination_name, :destination_address, :description, :user_id)
  end

  def adjust_schedule_params
    adjust_latlng = schedule_params
    lat, lng = params[:schedule][:destination_lat_lng].delete("()").split(/,/)
    adjust_latlng[:destination_lat] = lat.to_f
    adjust_latlng[:destination_lng] = lng.to_f
    return adjust_latlng
  end
end