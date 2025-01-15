class UserController < ApplicationController
    def index
    end
    def profile
        @user = User.find(current_user.id)
    end 
    def avatar
        user = User.find(current_user.id)
        if user.avatar.attach(avatar_params[:avatar])
          redirect_to request.referrer, notice: "The image was saved successfully!", allow_other_host: true
        else
          redirect_to request.referrer, alert: "Failed to save the image."
        end
      end
      
      private
      
      def avatar_params
        params.permit(:avatar)
      end
      
end