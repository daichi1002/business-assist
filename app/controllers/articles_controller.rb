class ArticlesController < ApplicationController
  before_action :search_article, only: [:index, :search]
  def index
    @articles = Article.includes(:user).order('created_at DESC').limit(4)
    @ranks = Article.find(Like.group(:article_id).order('count(article_id) DESC').limit(4).pluck(:article_id))
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments.includes(:user).order('created_at DESC').limit(7)
  end

  def search
  end

  private

  def search_article
    @a = Article.ransack(params[:q])
    @results = @a.result
  end
end
