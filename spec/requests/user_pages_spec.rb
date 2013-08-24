require 'spec_helper'

describe "User Pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: 'Join') }
		it { should have_selector('title', text: full_title('Join')) }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_selector('h1',    text: user.name) }
		it { should have_selector('title', text: user.name) }
	end

	describe "signup" do

		before { visit signup_path }

		let(:submit) { "Join" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",      with: "Marie Curie"
				fill_in "Email",     with: "marie@batman.com"
				fill_in "Password",  with: "radioactive"
				fill_in "Confirm password", with: "radioactive"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end
	end
end