class CommunityController < ApplicationController
    def index
        @communities = Community.all
      end      
    def create
        community = Community.create(name: params[:name])
        
        if community.save
            community.image.attach(params[:image])
            redirect_to root_path, notice: "Community created successfully."
        else
            redirect_to root_path, alert: "Failed to create community. Please try again."
        end
    end
end