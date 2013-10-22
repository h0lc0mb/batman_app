class StaticPagesController < ApplicationController
  def home
  	@post = current_user.posts.build if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end

  def contribute
  	@contribution = current_user.contributions.build if signed_in?
  end
end