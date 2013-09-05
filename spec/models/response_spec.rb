require 'spec_helper'

describe Response do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post) }

  before { @response = FactoryGirl.create(:response, user: user, post: post) }

  subject { @response }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:post_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  it { should respond_to(:post) }
  its(:post) { should == post }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @response.user_id = nil }
  	it { should_not be_valid }
  end

  describe "when post_id is not present" do
  	before { @response.post_id = nil }
  	it { should_not be_valid }
  end

  describe "with blank content" do
  	before { @response.content = " " }
  	it { should_not be_valid }
  end

  describe "with content that is too long" do
  	before { @response.content = "a" * 2501 }
  	it { should_not be_valid }
  end

  describe "accessbile attributes" do
  	it "should not allow access to post_id" do
  		expect do
  			Response.new(post_id: post.id)
  		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end

  	it "should not allow access to user_id" do
  		expect do
  			Response.new(user_id: user.id)
  		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end
end