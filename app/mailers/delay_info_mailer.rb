class DelayInfoMailer < ApplicationMailer
  def delay_info
    Schedule.find_each do |schedule|
      if schedule.meeting_time > 1.hours.ago && schedule.meeting_time < 1.hours.since
        @schedule = schedule
        mail(to: @schedule.user.email, subject: '遅刻しても焦らないで')
      end
    end
  end
end
