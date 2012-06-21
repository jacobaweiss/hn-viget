class CommentsController < ApplicationController
  before_filter :require_login, :only => [:new, :create]
  before_filter :get_parent
  
  def new
    @comment = @parent.comments.build
  end
  
  def create
    @comment = @parent.comments.build(params[:comment])
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to article_path(@comment.article), :notice => "Your comment has been saved!"
    else
      render :action => 'new'
    end
  end
  
  private
  
  def get_parent
    @parent = Article.find_by_id(params[:article_id]) if params[:article_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    
    redirect_to "/" unless defined?(@parent)
  end
end
