FactoryGirl.define do
  factory :vote do
    user_id '4'
    votable { Factory(:article) }
  end
end