class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :rescue_not_found
  include SimplestAuth::Controller
  
  protected
  
  def rescue_not_found
    render :file => "public/404.html", :status => 404
  end
  
  private
  
  def require_login
    unless logged_in?
      respond_to do |format|
        format.html { redirect_to login_url, :error => "You must be logged in to access this section" }
        format.js
      end
    end
  end
  
end