FactoryBot.define do
  factory :post_1, class: Post do
    association :category, factory: :challenge
    sequence(:title) { |i| "test#{i}" }
    sequence(:content) { |i| "This is a test post#{i}." }
  end

  factory :post_2, class: Post do
    association :user, factory: :john
    association :category, factory: :challenge
    sequence(:title) { |i| "test#{i}" }
    sequence(:content) { |i| "This is a test post#{i}." }
  end
end
