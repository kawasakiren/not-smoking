class ApplicationController < ActionController::Base
    include SessionsHelper
    
    private
    
    def require_user_logged_in
      unless logged_in?
        redirect_to login_url
      end
    end
    
    def forbid_login_user
        if current_user
            flash[:info] = "すでにログインしています"
            redirect_to "/users/#{session[:user_id]}"
        end
    end
    
    def forbid_not_follower(user)
        unless user.followers.find_by(id: current_user.id)
            redirect_back(fallback_location: users_path)
        end
    end
    
    def counts(user)
        @count_followings = user.followings.count
        @count_followers = user.followers.count
    end
end
