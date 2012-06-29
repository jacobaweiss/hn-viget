class CommentsController < ApplicationController
  before_filter :require_login
  before_filter :get_parent
  before_filter :time_limit, :only => [:edit]
  
  def new
    @comment = @parent.comments.build
  end
  
  def create
    @comment = @parent.comments.build(params[:comment])
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to article_url(@comment.article), :notice => "Your comment has been saved!"
    else
      render :action => 'new'
    end
  end
  
  def edit
  end

  def update
    @comment = @parent.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to article_url(@comment.article), :notice => "Your comment has been saved!"
    else
      render :action => 'edit'
    end
  end
  
  def vote
    @comment = Comment.find(params[:comment_id])
    unless current_user.has_voted?(@comment)
      @comment.votes.create(:value => params[:value], :user => current_user)
      @comment.reload
      respond_to do |format|
        format.html { redirect_to @comment.article, only_path: true }
        format.js
      end
    else
      redirect_to @comment.article, :notice => "You have already voted on this.", only_path: true
    end
  end
  
  private
  
  def get_parent
    @parent = Article.find_by_id(params[:article_id]) if params[:article_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    
    redirect_to root_url unless defined?(@parent)
  end
  
  def time_limit
    @comment = @parent.comments.find(params[:id])
    if (Time.now - @comment.created_at) > 5.minutes
      redirect_to @comment.article, :notice => "Too much time has passed to update this comment.", only_path: true
    end
  end
end