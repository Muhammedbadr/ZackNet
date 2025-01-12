class PostController < ApplicationController
    def create
        post = Post.create(user_id: current_user.id, post_text: params[:post_text], has_image: false)
      
        if post.save
        post.image.attach(params[:image])
          redirect_to request.referrer, notice: "Post added successfully!", allow_other_host: true
        else
          redirect_to request.referrer, alert: "Failed to add the post: #{post.errors.full_messages.to_sentence}", allow_other_host: true
        end
      end
      
end