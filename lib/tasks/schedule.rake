namespace :schedule do
  desc '登録した予定時間になると結果を出力する'
  task output_result: :environment do
    Schedule.new().get_result
  end
end
