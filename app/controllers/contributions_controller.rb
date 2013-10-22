class ContributionsController < ApplicationController
	before_filter :signed_in_user

# prob don't need this but messing around
	def new
		@contribution = current_user.contributions.build
	end

	def create
		@contribution = current_user.contributions.build(params[:contribution])
		#@userid = @contribution.user_id
		#@email = current_user.email
		#if @contribution.save
		if @contribution.save_with_payment
			flash[:success] = "Your generosity impresses us, grasshopper. Thank you for you contribution."
			redirect_to @contribution
		else
			render 'new'
		end
	end

	def show
		@contribution = Contribution.find(params[:id])
	end
end