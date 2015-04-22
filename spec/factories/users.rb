require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email-#{srand}@test.com" }
    password 'a password'
    password_confirmation 'a password'

    factory :admin do
      roles { [Role.where(name: 'admin').first_or_create] }
    end
  end
end
