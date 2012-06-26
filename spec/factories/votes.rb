FactoryGirl.define do
  factory :vote do
    user_id '4'
    votable_id '2'
    votable_type 'article'
  end
end