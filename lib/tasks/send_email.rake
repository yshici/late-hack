namespace :send_email do
  desc '登録した待ち合わせ時間前に遅刻情報メールを送信する'
  task send_delay_info_email: :environment do
    DelayInfoMailer.delay_info.deliver_now
  end
end
