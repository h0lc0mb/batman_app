class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:destroy, :index]
  before_filter :correct_or_admin,     only: [:show]
  
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "The Physics Ninja welcomes you."
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def toggle_admin
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    flash[:success] = "Newly minted ninja!"
    redirect_to users_path
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    # This part probably isn't working--why render @responses doesn't work
    @posts.each do |post|
      @responses = post.responses
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def correct_or_admin
      @user = User.find(params[:id])
      redirect_to root_url, notice: "Sorry, grasshopper: You must be a ninja to view that page." unless current_user?(@user) || current_user.try(:admin?)
    end

   # def admin_user
    #  redirect_to root_url, notice: "Sorry, grasshopper: You must be a ninja to view that page." unless current_user.admin?
    #end
end