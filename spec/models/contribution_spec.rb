require 'spec_helper'

describe Contribution do
  
  let(:user) { FactoryGirl.create(:user) }
  before do
  	@contribution = user.contributions.build(amount: 10.50)
  end

  subject { @contribution }

  it { should respond_to(:amount) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
  	before { @contribution.user_id = nil }
  	it { should_not be_valid }
  end

  describe "accessible attributes" do
  	it "should not allow access to user_id" do
  		expect do
  			Contribution.new(user_id: user.id)
  		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  describe "with blank amount" do
  	before { @contribution.amount = " " }
  	it { should_not be_valid }
  end

# idk why failing...my regex looks ok
  describe "with invalid amount" do
  	before { @contribution.amount = 5.000 }
  	it { should_not be_valid }
  end

  describe "with crazy amount" do
  	before { @contribution.amount = 50000.00 }
  	it { should_not be_valid }
  end

  describe "with zero amount" do
  	before { @contribution.amount = 0 }
  	it { should_not be_valid }
  end
end