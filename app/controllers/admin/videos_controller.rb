class Admin::VideosController < Admin::ApplicationController
  
 	load_and_authorize_resource :area
	load_and_authorize_resource :through => :area
 	
 	helper_method :permission
  before_filter :find_parent_model

	def new
    @video = @area.videos.new
	end

	def create
    @video = @area.videos.new params[:video]
		if @video.save
		  redirect_to admin_area_url(@area), :notice => t("helpers.messages.new", :model_name => Video.model_name.human)
	  else
		  render :new
	  end
	end

	def edit
	end

	def update
   if @video.update_attributes params[:video]
     redirect_to admin_area_url(@area), :notice => t("helpers.messages.edit", :model_name => Video.model_name.human)
   else
     render :edit
   end
	end

	def destroy
		if @video.destroy
		  redirect_to admin_area_url(@area), :notice => t("helpers.messages.destroy", :model_name => Video.model_name.human)
		else
		  redirect_to admin_area_url(@area), :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Video.name, "permission.controllers.admin.videos"
  end
  
  def find_parent_model
    @area = Area.find params[:area_id]
    @model = @area.areable_type.constantize.find @area.areable_id
  end
end
