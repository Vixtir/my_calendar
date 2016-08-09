FactoryGirl.define do
  factory :user do
    full_name "Paul"
    sequence(:email) { |n| "email#{n}.com" }
    password "password"
    password_confirmation "password"
  end
end
