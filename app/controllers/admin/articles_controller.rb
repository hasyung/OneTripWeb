class Admin::ArticlesController < Admin::ApplicationController

	load_and_authorize_resource :area
	load_and_authorize_resource :through => :area

	helper_method :permission
  before_filter :find_parent_model

	def show
	end

	def new
     @article = @area.articles.new
	end

	def create
    @article = @area.articles.new params[:article]
		if @article.save
			redirect_to admin_area_url(@area), :notice => t("helpers.messages.new", :model_name => Article.model_name.human)
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @article.update_attributes params[:article]
    	redirect_to admin_area_url(@area), :notice => t("helpers.messages.edit", :model_name => Article.model_name.human)
    else
    	render :edit
    end
	end

	def destroy
		if @article.destroy
			redirect_to admin_area_url(@area), :notice => t("helpers.messages.destroy", :model_name => Article.model_name.human)
		else
			redirect_to admin_area_url(@area), :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Article.name, "permission.controllers.admin.articles"
  end

  def find_parent_model
    @area = Area.find params[:area_id]
    @model = @area.areable_type.constantize.find @area.areable_id
  end
  
end
