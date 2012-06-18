# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "user@example.org"
    password "foo"
    password_confirmation "foo"
  end
end
