FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user    
    association :visited, factory: :user
    association :promotion
    action { "" }
    checked { false }
  end
end
