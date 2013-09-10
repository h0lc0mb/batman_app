require 'spec_helper'

describe "Post pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "post creation" do
		before { visit root_path }

		describe "with invalid information" do

			it "should not create a post" do
				expect { click_button "Submit" }.not_to change(Post, :count)
			end

			describe "error messages" do
				before { click_button "Submit" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do

			before { fill_in 'post_content', with: "Those who can...do?" }
			it "should create a post" do
				expect { click_button "Submit" }.to change(Post, :count).by(1)
			end
		end
	end

	describe "as an admin" do
		let(:admin) { FactoryGirl.create(:admin) }
		before { sign_in admin }
		
		describe "index" do
			before do
				FactoryGirl.create(:post, content: 'Is time real?')
				FactoryGirl.create(:post, content: 'Is space real?')
				visit posts_path
			end

			it { should have_selector('title', text: 'All questions') }
			it { should have_selector('h1',    text: 'All questions') }

			it "should list each post" do
				Post.all.each do |post|
					page.should have_selector('li', text: post.content)
				end
			end
		end

		describe "subindex" do
			let!(:ap1) { FactoryGirl.create(:post, content: 'This one has an answer') }
			let!(:ap2) { FactoryGirl.create(:post, content: 'So does this one') }
			let!(:pp1) { FactoryGirl.create(:post, content: 'This one does not have an answer') }
			let!(:pp2) { FactoryGirl.create(:post, content: 'Neither does this one') }
			
			before do
				@r1 = FactoryGirl.create(:response, post: ap1)
				@r2 = FactoryGirl.create(:response, post: ap2)
			end

			describe "answered" do
				before { visit answered_path }

				it { should have_selector('title', text: 'Answered questions') }
			  it { should have_selector('h1',    text: 'Answered questions') }
				
				it "should list each answered post" do
					page.should have_selector('li', text: ap1.content)
					page.should have_selector('li', text: ap2.content)
				end

				it "should not include unanswered posts" do
					page.should have_no_selector('li', text: pp1.content)
					page.should have_no_selector('li', text: pp2.content)
				end
			end

			 describe "pending" do
			 	before { visit pending_path }

				it { should have_selector('title', text: 'Pending questions') }
			  it { should have_selector('h1',    text: 'Pending questions') }

				it "should list each unanswered post" do
					page.should have_selector('li', text: pp1.content)
					page.should have_selector('li', text: pp2.content)
				end

				it "should not include answered posts" do
					page.should have_no_selector('li', text: ap1.content)
					page.should have_no_selector('li', text: ap2.content)
				end
			end
		end

		describe "show page" do
			let(:post) { FactoryGirl.create(:post) }
			before { visit post_path(post) }

			it { should have_content(post.content) }
		end
	end
end