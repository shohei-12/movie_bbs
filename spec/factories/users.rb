FactoryBot.define do
  factory :john, class: User do
    name { 'john' }
    email { 'john@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :dummy, class: User do
    sequence(:name) { |i| "user-#{i}" }
    sequence(:email) { |i| "user-#{i}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end