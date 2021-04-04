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
end
