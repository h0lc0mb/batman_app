require 'spec_helper'

describe "ContributionPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "contribution submission" do
		before { visit root_path }

		describe "with invalid information" do

			it "should not submit a contribution" do
				expect { click_button "Submit" }.not_to change(Contribution, :count)
			end

			describe "error messages" do
				before { click_button "Submit" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before { fill_in 'amount', with: 10.00 }
			it "should submit a contribution" do
				expect { click_button "Submit" }.to change(Contribution, :count)
			end
		end
	end
end