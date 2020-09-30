FactoryBot.define do
  factory :announcement do
    association :user
    content { 'このアナウンスメントはテストです。' }
  end
end
