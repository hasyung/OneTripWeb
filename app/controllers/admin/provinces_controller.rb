class Admin::ProvincesController < Admin::ApplicationController

	def index
		@provinces = Province.page(params[:page]).per(Setting.admin_PageSize)
	end

	def new
		@province = Province.new
	end

	def create
		@province = Province.new params[:province]
		if @province.save
			redirect_to :admin_provinces, :notice => t("helpers.messages.new", :model_name => Province.model_name.human)
		else
			render :new
		end
	end

	def edit
		@province = Province.find params[:id]
	end

	def update
		@province = Province.find params[:id]
    if @province.update_attributes params[:province]
      redirect_to :admin_provinces, :notice => t("helpers.messages.edit", :model_name => Province.model_name.human)
    else
      render :action => "edit"
    end
	end

	def destroy
		@province = Province.find params[:id]
    if @province.destroy
      redirect_to :admin_provinces, :notice => t("helpers.messages.destroy", :model_name => Province.model_name.human)
    else
      redirect_to :admin_provinces, :alert => t("helpers.messages.error")
    end
	end

	def destroy_multiple
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
			@provinces = Province.search_name(params[:province][:name]).page(params[:page]).per(Setting.admin_PageSize)
		end
		render :action => "index"
	end
	
end
