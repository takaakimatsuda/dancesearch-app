FactoryBot.define do
  factory :promotion do
    association :user 
    association :writer, factory: :user
    content { 'これはプロモーションテストです。' }
  end
end
