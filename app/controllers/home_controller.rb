class HomeController < ApplicationController
  def index
    if current_user
      @posts = Post.where.not(user_id: current_user.id).order(created_at: :desc)
    else
      @posts = [] # Optional: Can be omitted if @posts is not used when user is not signed in
    end
  end
end
