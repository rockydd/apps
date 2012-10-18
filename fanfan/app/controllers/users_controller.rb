class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to "/activities"
    else
      render :action => 'new'
    end
  end
  
  def home
    
  end

  def update_password
    password_old = params[:change_passwd]['password']
    password_new = params[:change_passwd]['pass2']
    
    unless current_user.blank?
      @ok = current_user.change_password(password_old, password_new)
      if @ok 
        current_user.save!
      end
    end
  end
end
