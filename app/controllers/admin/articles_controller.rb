class Admin::ArticlesController < Admin::ApplicationController

	before_filter :get_place

	def new
		@article = @place.articles.new params[:article]
	end
  
 def show
  @article = Article.find params[:id]
 end

	def create
		@article = @place.articles.new params[:article]
		if @article.save
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Article.model_name.human)
		else
			render :new
		end
	end

	def edit
		@article = Article.find params[:id]
	end

	def update
		@article = Article.find params[:id]
		if @article.update_attributes params[:article]
    	redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Article.model_name.human)
    else
    	render :edit
    end
	end

	def destroy
		@article = Article.find params[:id]
		if @article.destroy
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.destroy", :model_name => Article.model_name.human)
		else
			redirect_to admin_place_url(@place), :alert => t("helpers.messages.error")
		end
	end

	private
	def get_place
		@place = Place.find params[:place_id]
	end

end
