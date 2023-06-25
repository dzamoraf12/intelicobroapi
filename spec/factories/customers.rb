FactoryBot.define do
  factory :customer do
    customer_number { |i| rand(1..1000) + i.object_id }
    name { Faker::Name.first_name }
    paternal_name { Faker::Name.last_name }
    maternal_name { Faker::Name.last_name }
  end
end
