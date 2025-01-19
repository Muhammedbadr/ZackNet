class HomeController < ApplicationController
  def index
    @feeds = []
    if current_user
      user = User.find(current_user.id)
      user_following = user.following.map { |f| f.followed_id }
 
      posts = Post.where(user_id: user_following)
      comments = Comment.where(user_id: user_following)
      reposts = Repost.where(user_id: user_following)
      all_activities = posts + comments + reposts 
      @feeds = all_activities.sort_by(&:created_at).reverse
    end
  end
end
