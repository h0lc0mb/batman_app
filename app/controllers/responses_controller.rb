class ResponsesController < ApplicationController
	before_filter :admin_user

	def create
		@post = Post.find(params[:post_id])
		@response = @post.responses.build(params[:response])
		@response.user = current_user

		if @response.save
			flash[:success] = "Many thanks, ninja."
			redirect_to @post
		else
			render 'posts/show'
		end
	end

	def destroy
	end
end