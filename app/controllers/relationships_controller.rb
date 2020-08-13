class RelationshipsController < ApplicationController
  
    def create
        user =User.find(params[:follow_id])
        following = current_user.follow(user)
        if following.save
            redirect_back(fallback_location: users_path)
        else
            redirect_to :back
        end
    end
  
    def destroy
        user =User.find(params[:follow_id])
        following = current_user.unfollow(user)
        if following.destroy
            redirect_back(fallback_location: users_path)
        else
            redirect_to :back
        end
    end
end