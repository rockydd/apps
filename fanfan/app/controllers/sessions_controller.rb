class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully."
      redirect_to :controller => :activities, :action => :index
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end


  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to "/"
  end

  def change_theme
    ## should load from some where else. e.g db
    if session[:theme].nil? || session[:theme] == "red"
      session[:theme] = "base"
    else
      session[:theme] = "red"
    end
  end
end
