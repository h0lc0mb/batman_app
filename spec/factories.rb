FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Pascal #{n}" }
    sequence(:email) { |n| "pascal_#{n}@batman.com"}
    password "scandale"
    password_confirmation "scandale"

    factory :admin do
    	admin true
    end
  end

  factory :post do
  	content "What is time?"
  	user
  end
end