FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    cellphone { Faker::PhoneNumber.cell_phone }
    agent
  end
end