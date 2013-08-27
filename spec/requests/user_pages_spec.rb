require 'spec_helper'

describe "User Pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: 'Welcome') }
		#it { should have_selector('title', text: full_title('Welcome')) }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_selector('h1',    text: user.name) }
		it { should have_selector('title', text: user.name) }
	end

	describe "signup" do

		before { visit signup_path }

		let(:submit) { "Continue" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "username",  with: "Marie Curie"
				fill_in "email",     with: "marie@batman.com"
				fill_in "password",  with: "radioactive"
				fill_in "confirm password", with: "radioactive"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by_email('marie@batman.com') }

				it { should have_selector('title', text: user.name) }
				it { should have_selector('div.alert.alert-success', text: 'welcomes') }
				it { should have_link('Sign out') }
			end
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user)
		end

		describe "page" do
			it { should have_selector('h1',    text: "Update your profile") }
			it { should have_selector('title', text: "Edit user") }
		end

		describe "with invalid information" do
			let(:new_name)  { "Paul Langevin" }
			let(:new_email) { "paul@batman.com" }
			before do
				fill_in "username",         with: new_name
				fill_in "email",            with: new_email
				fill_in "password",         with: user.password
				fill_in "confirm password", with: user.password
				click_button "Save changes"
			end

			it { should have_selector('title', text: new_name) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Sign out', href: signout_path) }
			specify { user.reload.name.should  == new_name }
			specify { user.reload.email.should == new_email }
		end
	end
end