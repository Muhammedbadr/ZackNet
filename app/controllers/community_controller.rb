class CommunityController < ApplicationController
    def index
        @user = User.find(current_user.id)
        @communities = Community.all
    end     

      def create
        community = Community.new(name: params[:name])
        
        if community.save
          # Attach image if provided
          if params[:image].present?
            community.image.attach(params[:image])
          end
          redirect_to root_path, notice: "Community created successfully."
        else
          redirect_to root_path, alert: "Failed to create community. Please try again."
        end
      end
      
    def join
        if CommunityUser.create(user_id: current_user.id, community_id: params[:community_id])
            redirect_to root_path, notice: "Joined successfully."
        else
            redirect_to root_path, alert: "Failed to join community."
        end
    end

    def leave
        if CommunityUser.where(user_id: current_user.id, community_id: params[:community_id]).destroy_all
          redirect_to root_path, notice: "Left successfully."
        else
          redirect_to root_path, alert: "Failed to leave community."
        end
      end
      
      private

      def community_params
        params.permit(:name, :image)
      end
    end
