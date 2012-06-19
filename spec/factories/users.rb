# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "lindsey@bluth.org"
    password "beads"
    password_confirmation "beads"
  end
end
