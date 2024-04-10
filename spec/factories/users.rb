FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'testpassword123' }
  end
end
