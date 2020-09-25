FactoryBot.define do
  factory :score do
    user
    point { rand(1..5)}
  end
end