class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[show edit update destroy]

  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = current_user.schedules.new(adjust_schedule_params)
    binding.pry
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
    params.require(:schedule).permit(:name, :meeting_time, :destination_name, :destination_address, :destination_lat_lng, :description, :user_id)
  end

  def adjust_schedule_params
    lat, lng = schedule_params[:destination_lat_lng].delete("()").split(/,/)
    adjust = schedule_params
    adjust.delete(:destination_lat_lng)
    # lat, lng = params[:schedule][:destination_lat_lng].delete("()").split(/,/)
    adjust[:destination_lat] = lat.to_f
    adjust[:destination_lng] = lng.to_f
    adjust[:meeting_time] = DateTime.parse(adjust[:meeting_time])
    return adjust
  end
end