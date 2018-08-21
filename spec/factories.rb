FactoryBot.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:name) { |n| "John#{n}" }
  factory :user do
    name
    email
    password { "password" }
    admin { false }
    vendor { false }
  end

  factory :vendor, class: User do
    name
    email
    password { "password" }
    admin { false }
    vendor { true }
  end

  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    name
    email
    password { "password" }
    admin { true }
    vendor { true }
  end

  factory :flat do
    name { "Modern flat" }
    city { 'Uzhgorod' }
    address { 'Some Street 19' }
    description { 'Nice flat!' }
    price { 35 }
    capacity { 2 }
    vendor
  end
end
