class Admin::CategoriesController < Admin::ApplicationController
  
  load_and_authorize_resource
  
  helper_method :permission
  
  def index
    @categories = @categories.page(params[:page]).per(Setting.admin_PageSize)
  end
  
  def show
    @category = Category.find_by_slug params[:category_slug]
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new params[:category]
    if @category.save
      redirect_to :admin_categories, :notice => t("helpers.messages.new", :model_name => Category.model_name.human)
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @category.update_attributes params[:category]
      redirect_to :admin_categories, :notice => t("helpers.messages.edit", :model_name => Category.model_name.human)
    else
      render :edit
    end
  end
  
  def destroy
    if @category.destroy
      redirect_to :admin_categories, :notice => t("helpers.messages.destroy", :model_name => Category.model_name.human)
    else
      redirect_to :admin_categories, :alert => t("helpers.messages.error")
    end
  end
  
	def search
		if params[:category][:name].blank?
			redirect_to :admin_categories, :alert => t("helpers.messages.search_error")
			return
		else
			@categories = @categories.search_name(params[:category][:name]).page(params[:page]).per(Setting.admin_PageSize)
		end
		render :action => "index"
	end
  
	private
	def self.permission
  	return Category.name, "permission.controllers.admin.categories"
  end
  
end
