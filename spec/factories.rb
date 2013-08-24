FactoryGirl.define do
	factory :user do
		name     "Blaise Pascal"
		email    "blaise@batman.com"
		password "scandale"
		password_confirmation "scandale"
	end
end