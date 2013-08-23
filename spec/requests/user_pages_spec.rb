require 'spec_helper'

describe "User Pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_selector('h1', text: 'Join') }
		it { should have_selector('title', text: full_title('Join')) }
	end
end