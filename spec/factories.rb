FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Pascal_#{n}" }
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

  factory :response do
    content "Time is an illusion"
    post
    user
  end
end