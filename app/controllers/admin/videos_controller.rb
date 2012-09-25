class Admin::VideosController < Admin::ApplicationController
  
 	load_and_authorize_resource :place
	load_and_authorize_resource :through => :place
 	
 	helper_method :permission

	def new
	end

	def create
		if @video.save
		  redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Video.model_name.human)
	  else
		  render :new
	  end
	end

	def edit
	end

	def update
   if @video.update_attributes params[:video]
     redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Video.model_name.human)
   else
     render :edit
   end
	end

	def destroy
		if @video.destroy
		  redirect_to admin_place_url(@place), :notice => t("helpers.messages.destroy", :model_name => Video.model_name.human)
		else
		  redirect_to admin_place_url(@place), :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Video.name, "permission.controllers.admin.videos"
  end
end
