class VotesController < ApplicationController
  def new
    @vote = Vote.new
  end
  
  def create
    @vote = @votable.votes.build(params[:vote])
    if @vote.save
      flash[:success] = "Vote saved!"
    else
      flash[:error] = "Vote not saved!"
    end
  end
  
  def votable
    @votable = Article.find_by_id(params[:article_id]) if params[:article_id]
    @votable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
  end
  
end
