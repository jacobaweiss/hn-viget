class UserMailer < ActionMailer::Base
  require 'securerandom'
  default from: "1337krew@haxxornews.com"
  
  def reset_password(user)
    @user = user
    @new_password = SecureRandom.hex(10)
    @user.update_attributes(:password => @new_password, :password_confirmation => @new_password)
    mail(:to => user.email, :subject => "Reset Password")
  end
end
