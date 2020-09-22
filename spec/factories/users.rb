FactoryBot.define do
  factory :user do
    sequence(:name, 1) { |n| "TEST_NAME#{n}"}
    sequence(:email, 1) { |n| "TEST#{n}@example.com"}
    password { 'password' }
    password_confirmation { 'password' }
  end
end