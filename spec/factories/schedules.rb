FactoryBot.define do
  factory :schedule do
    sequence(:name) { |n| "schedule#{n}" }
    meeting_time { Time.now }
    destination_name { '渋谷駅' }
    destination_address { '日本、〒150-0002 東京都渋谷区渋谷２丁目２４' }
    destination_lat { '35.6580339' }
    destination_lng { '139.7016358' }
    start_point_name { '新宿駅' }
    start_point_address { '日本、〒160-0022 東京都新宿区新宿３丁目３８−１' }
    start_point_lat { '35.6896067' }
    start_point_lng { '139.7005713' }
    association :user
  end
end
