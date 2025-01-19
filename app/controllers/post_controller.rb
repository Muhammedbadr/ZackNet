class PostController < ApplicationController
  # Create a new post
  def create
    post = Post.new(user_id: current_user.id, post_text: params[:post_text], has_image: params[:image].present?)

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

  def destroy
    post = Post.find_by(id: params[:post_id]) # Assuming you pass the post_id

    if post && post.destroy
      redirect_to root_path, notice: "Post deleted successfully."
    else
      redirect_to root_path, alert: "Unable to delete the post."
    end
  end
  
  
  
end