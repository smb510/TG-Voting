class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :authorize_admin
  protect_from_forgery
  
  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please Log In"
      end
    end
    
    def authorize_admin
      unless ["mplis", "scbiddle", "lrodgers", "csar", "travism"].include?(session[:user_name])
        redirect_to elections_url, :notice => "You cannot see that page"
      end
    end
    
    def ensure_proxy
      unless User.find_by_id(session[:user_id]).proxy_id > 0
        redirect_to elections_url, :notice => "You are not a proxy."
    end
  end
  
  
end
