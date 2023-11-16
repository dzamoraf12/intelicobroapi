FactoryBot.define do
  factory :visit do
    penalty_amount { "9.99" }
    comments { "Cliente no se encuentra en su domicilio" }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    status { "pending" }
    customer_id { create(:customer).id }
    user_id { create(:user).id }

    trait :with_invalid_data do
      penalty_amount { "" }
      comments { "" }
    end
  end
end
