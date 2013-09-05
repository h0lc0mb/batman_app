require 'spec_helper'

describe Post do

	let(:user) { FactoryGirl.create(:user) }
	before { @post = user.posts.build(content: "What is time?") }

	subject { @post }

	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should == user }
	it { should respond_to(:responses) }

	it { should be_valid }

	describe "accessible attributes" do
		it "should not allow access to user_id" do
			expect do
				Post.new(user_id: user.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	describe "when user_id is not present" do
		before { @post.user_id = nil }
		it { should_not be_valid }
	end

	describe "with blank content" do
		before { @post.content = " " }
		it { should_not be_valid }
	end

	describe "with content that is too long" do
		before { @post.content = "a" * 2501 }
		it { should_not be_valid }
	end

	describe "response associations" do

		before { @post.save }
		let!(:response) do
			FactoryGirl.create(:response, post: @post)
		end

		it "should destroy association responses" do
			responses = @post.responses.dup
			@post.destroy
			responses.should_not be_empty
			responses.each do |response|
				Response.find_by_id(response.id).should be_nil
			end
		end
	end
end