# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "email#{n}@factory.com"
    end
    password "foofoofoo"
    password_confirmation "foofoofoo"
  end
end
