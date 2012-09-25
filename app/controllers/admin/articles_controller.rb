class Admin::ArticlesController < Admin::ApplicationController

	load_and_authorize_resource :place
	load_and_authorize_resource :through => :place

	helper_method :permission

	def show
	end

	def new
	end

	def create
		if @article.save
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Article.model_name.human)
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @article.update_attributes params[:article]
    	redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Article.model_name.human)
    else
    	render :edit
    end
	end

	def destroy
		if @article.destroy
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.destroy", :model_name => Article.model_name.human)
		else
			redirect_to admin_place_url(@place), :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Article.name, "permission.controllers.admin.articles"
  end

end
