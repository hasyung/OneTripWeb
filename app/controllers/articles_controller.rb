class ArticlesController < ApplicationController
  def show 
    @article = Article.find params[:id]
    @area = @article.area
    @model = @area.areable_type.constantize.find @area.areable_id
  end
end
