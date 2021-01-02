FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    role { :general }

    trait :admin do
      sequence(:name) { |n| "admin#{n}" }
      role { :admin }
    end
  end
end
