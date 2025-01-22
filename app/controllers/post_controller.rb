class PostController < ApplicationController
  before_action :authenticate_user!

  # Create a new post
  def create
    post = Post.create(user_id: current_user.id, post_text: params[:post_text], has_image: params[:image].present? , community_id: params[:community_id])

    if post.save
      post.image.attach(params[:image]) if params[:image].present?
      redirect_to request.referrer, notice: "Post added successfully!", allow_other_host: true
    else
      redirect_to request.referrer, alert: "Failed to add the post: #{post.errors.full_messages.to_sentence}", allow_other_host: true
    end
  end

  # Like or unlike a post
  def like
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    
    if like
      like.destroy
      redirect_to request.referrer, notice: "Like removed successfully!", allow_other_host: true
    else
      new_like = Like.new(user_id: current_user.id, post_id: params[:post_id])
      
      if new_like.save
        redirect_to request.referrer, notice: "Like added successfully!", allow_other_host: true
      else
        redirect_to request.referrer, alert: "Unable to like the post!", allow_other_host: true
      end
    end
  end

  def community_feed
    @feeds = Post.where(community_id: params[:community_id]).order(created_at: :desc)
  end
  
  # Comment on a post
  def comment
    comment = Comment.new(user_id: current_user.id, post_id: params[:post_id], comment_text: params[:comment_text])
    
    if comment.save
      redirect_to request.referrer, notice: "Message sent successfully!", allow_other_host: true
    else
      redirect_to request.referrer, alert: "Failed to send message: #{comment.errors.full_messages.to_sentence}", allow_other_host: true
    end
  end

  def repost
    repost = Repost.find_or_create_by(user_id: current_user.id, post_id: params[:post_id])
    redirect_to request.referrer, notice: "Post reposted successfully!", allow_other_host: true
  end
  
  
  
    # حذف منشور
    def destroy
      post = Post.find_by(id: params[:post_id])
    
      if post.nil?
        redirect_to request.referrer || root_path, alert: "Post not found.", allow_other_host: true
      elsif post.user_id == current_user.id
        # حذف السجلات المرتبطة يدويًا
        post.comments.destroy_all
        post.likes.destroy_all
        post.reposts.destroy_all
    
        post.destroy
        redirect_to request.referrer || root_path, notice: "Post deleted successfully!", allow_other_host: true
      else
        redirect_to request.referrer || root_path, alert: "You are not authorized to delete this post.", allow_other_host: true
      end
    end
    
  

  
   
  
  
  
end