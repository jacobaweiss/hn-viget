class UsersController < ApplicationController
  before_filter :require_login, :only => [:password, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Your account has been successfully created!"
      self.current_user = @user
      redirect_to @user
    else
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def password
  end
  
  def update
    if current_user.update_attributes(params[:user])
      flash[:success] = "Your password has been changed!"
      redirect_to root_path
    else
      render "password"
    end
  end
end
