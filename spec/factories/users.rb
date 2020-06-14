FactoryBot.define do
  factory :john, class: User do
    name { 'john' }
    email { 'john@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
