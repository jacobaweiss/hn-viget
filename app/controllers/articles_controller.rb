class ArticlesController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  before_filter :load_article, :only => [:edit, :update, :destroy]
  
  def index
    @articles = Article.chronological.page(params[:page]).per(20)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = self.current_user.articles.create(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
    end
  end
  
  private
  
  def load_article
    @article = current_user.articles.find(params[:id])
  end
  
end
