FactoryBot.define do
  factory :excuse do
    sequence(:content) { |n| "excuse#{n}" }
    late_time { 1 }
  end
end
