class ArticlesController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  before_filter :load_article, :only => [:edit, :update, :destroy]
  
  def index
    @articles = Article.top_for(params[:duration]).page(params[:page]).per(10)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
  end
  
  def vote
    @article = Article.find(params[:article_id])
    unless current_user.has_voted?(@article)
      @article.votes.create(:value => params[:value], :user => current_user)
      @article.reload
      respond_to do |format|
        format.html { redirect_to @article }
        format.js
      end
    else
      redirect_to @article, :notice => "You have already voted on this."
    end
  end

  def create
    @article = self.current_user.articles.create(params[:article])
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @article.update_attributes(params[:article])
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url
  end
  
  private
  
  def load_article
    @article = current_user.articles.find(params[:id])
  end
  
end