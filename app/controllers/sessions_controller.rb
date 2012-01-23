class SessionsController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :authorize_admin
  
  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      session[:user_name] = user.name
      redirect_to rushvotes_url
    else
      redirect_to login_url, :alert => "Login unsuccessful"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to login_url, :notice => "Logged Out"
  end

end
