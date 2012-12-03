class Admin::ProvincesController < Admin::ApplicationController

	load_and_authorize_resource

	helper_method :permission

	def index
		@provinces = @provinces.page(params[:page]).per(1)
	end

	def new
		
	end

	def create
		if @province.save
			redirect_to :admin_provinces, :notice => t("helpers.messages.new", :model_name => Province.model_name.human)
		else
			render :new
		end
	end

	def edit
		
	end

	def update
    if @province.update_attributes params[:province]
      redirect_to :admin_provinces, :notice => t("helpers.messages.edit", :model_name => Province.model_name.human)
    else
      render :action => "edit"
    end
	end

	def destroy
    if @province.destroy
      redirect_to :admin_provinces, :notice => t("helpers.messages.destroy", :model_name => Province.model_name.human)
    else
      redirect_to :admin_provinces, :alert => t("helpers.messages.error")
    end
	end

	def destroies
		if params[:province_ids].blank?
			return redirect_to :admin_provinces,
												 :alert => t("helpers.messages.selected_error",
												 							:model_name => Province.model_name.human)
		end
		if Province.destroy(params[:province_ids])
			redirect_to :admin_provinces, 
									:notice => t("helpers.messages.destroy_multiple", 
																:count => params[:province_ids].size,
																:model_name => Province.model_name.human)
		else
			redirect_to :admin_provinces, :alert => t("helpers.messages.notices.error")
		end
	end

	def search
		if params[:province][:name].blank?
			redirect_to :admin_provinces, :alert => t("helpers.messages.search_error")
			return
		else
			@provinces = @provinces.search_name(params[:province][:name]).page(params[:page]).per(1)
		end
		render :action => "index"
	end

	private
	def self.permission
  	return Province.name, "permission.controllers.admin.provinces"
  end
	
end
