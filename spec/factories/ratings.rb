# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    value 1
    rating_set { FactoryGirl.create(:rating_set) }
    rated_user { FactoryGirl.create(:user) }
  end
end
