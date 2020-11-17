class DelayInfoMailer < ApplicationMailer
  def delay_info
    get_api_info = ApiGet.new().get_api
    Schedule.find_each do |schedule|
      if schedule.meeting_time > 1.hours.ago && schedule.meeting_time < 1.hours.since
        @schedule = schedule
        get_api_info_with_position = ApiGet.new().get_api_with_position(schedule.destination_lat, schedule.destination_lng)
        @api_info = get_api_info.merge(get_api_info_with_position)
        mail(to: schedule.user.email, subject: "#{ l schedule.meeting_time, format: :long }の予定：#{ schedule.name }について")
      end
    end
  end
end
