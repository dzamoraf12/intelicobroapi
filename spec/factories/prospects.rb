FactoryBot.define do
  factory :prospect do
    names { Faker::Name.first_name }
    mother_surname { Faker::Name.last_name }
    father_surname { Faker::Name.last_name }
    street { Faker::Address.street_name }
    internal_number { Faker::Address.secondary_address }
    external_number { Faker::Address.building_number }
    zip_code { rand(80000..90000) }
    neighborhood { Faker::Address.community }
    municipality { Faker::Address.community }
    city { Faker::Address.city }
    state { Faker::Address.state }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    verification_status { "pending" }
    verified_at { }
    verification_accepted_at { }
    verification_rejected_at { }
    agent

    trait :with_invalid_data do
      names { "" }
      father_surname { "" }
      verification_status { "pendingg" }
    end
  end
end
