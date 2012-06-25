class VotesController < ApplicationController
  before_filter :get_parent
  
  def new
    @vote = Vote.new
  end
  
  def create
    @vote = @parent.votes.build(params[:vote])
    @vote.user = current_user
    
    if @vote.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
  
  def get_parent
    @parent = Article.find_by_id(params[:article_id]) if params[:article_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
  end
  
end
