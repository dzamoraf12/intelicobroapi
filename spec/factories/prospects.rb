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
    attaching_documents { [] }
    agent

    trait :with_invalid_data do
      names { "" }
      father_surname { "" }
      verification_status { "pendingg" }
    end

    trait :with_valid_documents do
      with_picture
      with_ID_front
      with_ID_back
      with_address_proof
    end

    trait :with_picture do
      after :build do |prospect|
        file_name = "logo-web.png"
        file_path = Rails.root.join("spec", "support", "fixtures", file_name)
        prospect.attaching_documents << "picture"
        prospect.picture.attach(io: File.open(file_path), filename: file_name, content_type: "image/png")
      end
    end

    trait :with_ID_front do
      after :build do |prospect|
        file_name = "logo-web.png"
        file_path = Rails.root.join("spec", "support", "fixtures", file_name)
        prospect.attaching_documents << "ID_front"
        prospect.ID_front.attach(io: File.open(file_path), filename: file_name, content_type: "image/png")
      end
    end

    trait :with_ID_back do
      after :build do |prospect|
        file_name = "logo-web.png"
        file_path = Rails.root.join("spec", "support", "fixtures", file_name)
        prospect.attaching_documents << "ID_back"
        prospect.ID_back.attach(io: File.open(file_path), filename: file_name, content_type: "image/png")
      end
    end

    trait :with_address_proof do
      after :build do |prospect|
        file_name = "logo-web.png"
        file_path = Rails.root.join("spec", "support", "fixtures", file_name)
        prospect.attaching_documents << "address_proof"
        prospect.address_proof.attach(io: File.open(file_path), filename: file_name, content_type: "image/png")
      end
    end
  end
end
