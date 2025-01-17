class HomeController < ApplicationController
  def index
    @feeds = []
    if current_user
      posts = Post.where.not(user_id: current_user.id).order(created_at: :desc)
      comments = Comment.where.not(user_id: current_user.id).order(created_at: :desc)
      reposts = Repost.where.not(user_id: current_user.id).order(created_at: :desc)
      all_activities = posts + comments + reposts 
      @feeds = all_activities.sort_by(&:created_at).reverse
    end
  end
end
