namespace :send_email do
  desc '登録した待ち合わせ時間前に遅刻情報メールを送信する'
  task send_delay_info_email: :environment do
    Schedule.find_each do |schedule|
      if schedule.meeting_time > 1.hours.ago && schedule.meeting_time < 1.hours.since
        DelayInfoMailer.with(schedule: schedule).delay_info.deliver_now
      end
    end
  end
end
