class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email])
    if @user
      UserMailer.reset_password(@user).deliver
      flash[:notice] = "Your new password has been sent to your email!"
      redirect_to "/"
    else
      flash[:error] = "We could not find that email address on our servers."
      redirect_to "/reset_password"
    end
  end
  
end
