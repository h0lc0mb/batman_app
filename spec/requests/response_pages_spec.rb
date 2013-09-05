require 'spec_helper'

describe "Response pages" do
	
	subject { page }

	let(:admin) { FactoryGirl.create(:admin) }
	before { sign_in admin }

	describe "response creation" do
		let(:post) { FactoryGirl.create(:post) }
		before { visit post_path(post) }

		describe "with invalid information" do

			it "should not create a response" do
				expect { click_button "Submit" }.not_to change(Response, :count)
			end

			describe "error messages" do
				before { click_button "Submit" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do

			before { fill_in 'response_content', with: "I have the answer!" }
			it "should create a response" do
				expect { click_button "Submit" }.to change(Response, :count).by(1)
			end
		end
	end
end