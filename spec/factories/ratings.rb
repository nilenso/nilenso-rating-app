# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    value 1
    association :rating_set, factory: :rating_set
    association :rated_user, factory: :user
  end
end
