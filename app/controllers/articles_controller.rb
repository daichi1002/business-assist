class ArticlesController < ApplicationController
  def index
    @articles = Article.includes(:user).order('created_at DESC').limit(4)
  end

  def show
    @article = Article.find(params[:id])
  end
end
