require 'spec_helper'

describe "User Pages" do

	subject { page }

	describe "index" do
		
		let(:admin) { FactoryGirl.create(:admin) }
		before do
			sign_in admin
			visit users_path
		end

		it { should have_selector('title', text: 'All users') }
		it { should have_selector('h1',    text: 'All users') }

		describe "pagination" do

			before(:all) { 30.times { FactoryGirl.create(:user) } }
			after(:all)  { User.delete_all }

			it { should have_selector('div.pagination') }

			it "should list each user" do
				User.paginate(page: 1).each do |user|
					page.should have_selector('li', text: user.name)
				end
			end
		end

		# idk why these are failing bc they appear to work in the app

		describe "delete links" do

			let(:user) { FactoryGirl.create(:user) }

			it { should have_link('delete', href: user_path(user)) }
			it "should be able to delete another user" do
				expect { click_link('delete') }.to change(User, :count).by(-1)
			end
			it { should_not have_link('delete', href: user_path(admin)) }
		end

		describe "admin links" do

			let(:user) { FactoryGirl.create(:user) }

			it { should have_link('make admin', href: user_path(user)) }
			it "should be able to make another user an admin" do
				expect { click_link('make admin') }.to change { user.admin }
			end
			it { should_not have_link('make admin', href: user_path(admin)) }
		end
	end

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: 'Welcome') }
		#it { should have_selector('title', text: full_title('Welcome')) }
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
				fill_in "username",  with: "MarieCurie"
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

				it { should have_content('Pending') }
				#it { should have_selector('title', text: user.name) }
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
			let(:new_name)  { "PaulLangevin" }
			let(:new_email) { "paul@batman.com" }
			before do
				fill_in "username",         with: new_name
				fill_in "email",            with: new_email
				fill_in "password",         with: user.password
				fill_in "confirm password", with: user.password
				click_button "Save changes"
			end

			it { should have_content('Pending') }
			#it { should have_selector('title', text: new_name) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Sign out', href: signout_path) }
			specify { user.reload.name.should  == new_name }
			specify { user.reload.email.should == new_email }
		end
	end

	describe "profile page" do

		let(:user) { FactoryGirl.create(:user) }
		let!(:p1) { FactoryGirl.create(:post, user: user, content: "What is rage?") }
		let!(:p2) { FactoryGirl.create(:post, user: user, content: "What are conics?") }
		let!(:p3) { FactoryGirl.create(:post, user: user, content: "This one has no answer!")}
		let!(:r1) { FactoryGirl.create(:response, post: p1, content: "See: Achilles") }
		let!(:r2) { FactoryGirl.create(:response, post: p2, content: "See: Conics") }

		before { visit user_path(user) }

		it { should have_content('Sorry, grasshopper') }

		describe "as an admin" do

			let(:admin) { FactoryGirl.create(:admin) }
			before do
				sign_in admin
				visit user_path(user)
			end

			it { should have_selector('h1',    text: user.name) }
			it { should have_selector('title', text: user.name) }

			describe "posts" do
				it { should have_content(p1.content) }
				it { should have_content(p2.content) }
				it { should_not have_content(p3.content) }
			end

			describe "responses" do
				it { should have_content(r1.content) }
				it { should have_content(r2.content) }
			end
		end
	end
end