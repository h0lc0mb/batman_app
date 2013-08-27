FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Pascal #{n}" }
    sequence(:email) { |n| "pascal_#{n}@batman.com"}
    password "scandale"
    password_confirmation "scandale"
  end
end