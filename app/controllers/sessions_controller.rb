class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      self.current_user = user
      flash[:success] = "You are now logged in!"
      redirect_to root_url
    else
      flash.now[:error] = "Couldn't find a user with those credentials."
      render :action => 'new'
    end
  end
  
  def destroy
    self.current_user = nil
    flash[:success] = "You have been signed out!"
    redirect_to root_url
  end
end
