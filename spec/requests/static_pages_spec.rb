require 'spec_helper'

describe "StaticPages" do

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_selector('h1', text: 'Ninja') }
		it { should have_selector('title', text: full_title('')) }
		it { should_not have_selector('title', text: "| Home") }

		describe "as signed in user" do
			let(:user) { FactoryGirl.create(:user) }

			before do
				sign_in user
				visit root_path
			end

			let!(:p1) { FactoryGirl.create(:post, user: user, content: "What is rage?") }
			let!(:p2) { FactoryGirl.create(:post, user: user, content: "What are conics?") }
			let!(:p3) { FactoryGirl.create(:post, user: user, content: "This post has an answer!")}
			let!(:r3) { FactoryGirl.create(:response, post: p3, content: "Yes, yes it does.") }

			describe "posts" do
				it { should have_content('Pending') }
				# These are failing, but it works in the app...
				it { should have_content(p1.content) }
				it { should have_content(p2.content) }
				it { should_not have_content(p3.content) }
			end
		end
	end

	describe "Help page" do
		before { visit help_path }

		it { should have_selector('h1', text: 'Help') }
		it { should have_selector('title', text: full_title('Help')) }
	end

	describe "About page" do
		before { visit about_path }

		it { should have_selector('h1', text: 'About') }
		it { should have_selector('title', text: full_title('About')) }
	end

	#describe "Contact page" do
	#	before { visit contact_path }

	#	it { should have_selector('h1', text: 'Contact') }
	#	it { should have_selector('title', text: full_title('Contact')) }
	#end
end