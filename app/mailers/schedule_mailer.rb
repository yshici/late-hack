class ScheduleMailer < ApplicationMailer
  def output_result(schedule)
    @schedule = schedule
    mail(to: schedule.user.email, subject: "遅刻してますか？")
  end
end
