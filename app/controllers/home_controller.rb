class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @feeds = []
    if current_user
      user = User.find(current_user.id) 
      user_following = user.following.map { |f| f.followed_id }
      posts = Post.where(user_id: user_following , community_id: nil)
      comments = Comment.where(user_id: user_following)
      reposts = Repost.where(user_id: user_following)
      community_posts = Post.where(community_id: user.community_users.map{|cu| cu.community_id})
      all_activities = posts + comments + reposts + community_posts 
      @feeds = all_activities.sort_by(&:created_at).reverse[(Integer(params[:page] || 1) * 10 ) - 10 , 10] || []
      @pages_count = (all_activities.length() / 10.to_f).ceil
    end
  end
end
