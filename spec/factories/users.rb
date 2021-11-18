FactoryBot.define do
  factory :user do
    username { 'user1' }
    email { 'user1@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
