FactoryBot.define do
  factory :post do
    association :user, factory: :john
    title { 'test' }
    content { 'This is a test post.' }
  end
end
