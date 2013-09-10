class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :admin_user,     only: [:show, :index]

  def create
  	@post = current_user.posts.build(params[:post])
  	if @post.save
  		flash[:success] = "Your question has been submitted to the ninja."
  		redirect_to root_url
  	else
  		render 'static_pages/home'
  	end
  end

  def destroy
  end

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def pending
    @posts = Post.all
  end

  def answered
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @response = @post.responses.build#(params[:response])

    # Do I need this?
    #@response.user = current_user
  end
end