class Admin::InfosController < Admin::ApplicationController

	load_and_authorize_resource :place
	load_and_authorize_resource :through => :place

	helper_method :permission

	def new
	end

	def create
	  if @info.save
		  redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Info.model_name.human)
	  else
		  render :new
	  end
	end

	def edit
	end

	def update
    if @info.update_attributes params[:info]
      redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Info.model_name.human)
    else
      render :edit
    end
	end

	def destroy
		if @info.destroy
		  redirect_to admin_place_url(@place), :notice => t("helpers.messages.destroy", :model_name => Info.model_name.human)
  	else
		  redirect_to admin_place_url(@place), :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Info.name, "permission.controllers.admin.infos"
  end
end
