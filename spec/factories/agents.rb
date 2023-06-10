FactoryBot.define do
  factory :agent do
    code { "123" }
    name { Faker::Name.first_name }
    address { Faker::Address.street_address }
    phone { Faker::PhoneNumber.cell_phone }
    cellphone { Faker::PhoneNumber.cell_phone }
    active { 1 }
    type { "type1" }
  end
end