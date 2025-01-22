class UserController < ApplicationController
  before_action :authenticate_user!
    def index
      @users = User.where.not(id: current_user.id)
    end
    def profile
      user = User.find(params[:id])
      posts = user.posts
      reposts = user.reposts
      all_activities = posts + reposts
      @feeds = all_activities.sort_by(&:created_at).reverse
      @user = user
    end
    
  
    def avatar
        user = User.find(current_user.id)
        if user.avatar.attach(avatar_params[:avatar])
          redirect_to request.referrer, notice: "The image was saved successfully!", allow_other_host: true
        else
          redirect_to request.referrer, alert: "Failed to save the image."
        end
    end

    def follow
        # التحقق مما إذا كانت العلاقة موجودة بالفعل
        existing_relationship = Relationship.find_by(follower_id: current_user.id, followed_id: params[:followed_id])
        redirect_to request.referrer, notice: "You started following succusfuly", allow_other_host: true
    
    end
    
    def unfollow
      # Fetch the user to unfollow based on the followed_id parameter
      @user = User.find_by(id: params[:followed_id])
      # Handle case if user not found
      if @user.nil?
        redirect_to request.referrer, alert: "User not found."
      else
        # Find the relationship where the current user is the follower and the user is the followed user
        relationship = Relationship.find_by(follower_id: current_user.id, followed_id: @user.id)
    
        # Delete the relationship if it exists
        if relationship
          relationship.destroy
          redirect_to request.referrer, notice: "You unfollowed #{@user.username}.", allow_other_host: true
        else
          redirect_to request.referrer, alert: "You are not following this user."
        end
      end
    end

    def username
      user = User.find(current_user.id)
      if user.update(username: params[:username])
        redirect_to request.referrer, notice: "Your username has been updated successfully!.", allow_other_host: true
        
      else
        redirect_to request.referrer, alert: "Failed to update your username."
      end
    end
    













      private
      
      def avatar_params
        params.permit(:avatar)
      end

      
      
end