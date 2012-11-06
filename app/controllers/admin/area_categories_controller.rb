class Admin::AreaCategoriesController < Admin::ApplicationController
  load_and_authorize_resource

	helper_method :permission

	def index
		@area_categories = @area_categories.page(params[:page]).per(Setting.admin_PageSize)
	end

	def new
		
	end

	def create
		if @area_category.save
			redirect_to :admin_area_categories, :notice => t("helpers.messages.new", :model_name => AreaCategory.model_name.human)
		else
			render :new
		end
	end

	def edit
		
	end

	def update
    if @area_category.update_attributes params[:area_category]
      redirect_to :admin_area_categories, :notice => t("helpers.messages.edit", :model_name => AreaCategory.model_name.human)
    else
      render :action => "edit"
    end
	end

	def destroy
    if @area_category.destroy
      redirect_to :admin_area_categories, :notice => t("helpers.messages.destroy", :model_name => AreaCategory.model_name.human)
    else
      redirect_to :admin_area_categories, :alert => t("helpers.messages.error")
    end
	end

	def destroies
		if params[:area_category_ids].blank?
			return redirect_to :admin_area_categories,
												 :alert => t("helpers.messages.selected_error",
												 							:model_name => AreaCategory.model_name.human)
		end
		if AreaCategory.destroy(params[:area_category_ids])
			redirect_to :admin_area_categories, 
									:notice => t("helpers.messages.destroy_multiple", 
																:count => params[:area_category_ids].size,
																:model_name => AreaCategory.model_name.human)
		else
			redirect_to :admin_area_categories, :alert => t("helpers.messages.notices.error")
		end
	end

	def search
		if params[:area_category][:name].blank?
			redirect_to :admin_area_categories, :alert => t("helpers.messages.search_error")
			return
		else
			@area_categories = @area_categories.search_name(params[:area_category][:name]).page(params[:page]).per(Setting.admin_PageSize)
		end
		render :action => "index"
	end

	private
	def self.permission
  	return AreaCategory.name, "permission.controllers.admin.area_categories"
  end
end
