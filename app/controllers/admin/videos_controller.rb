class Admin::VideosController < Admin::ApplicationController
  
 before_filter :get_place

	def new
		 @video = Video.new
	end

	def create
			@video = @place.videos.new params[:video]
		 if @video.save
			  redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Video.model_name.human)
		 else
			  render :new
		 end
	end

	def edit
		 @video = @place.videos.find params[:id]
	end

	def update
	  @video = @place.videos.find params[:id]
   if @video.update_attributes params[:video]
     redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Video.model_name.human)
   else
     render :edit
   end
	end

	def destroy
		 @video = @place.videos.find params[:id]
		 if @video.destroy
			  redirect_to admin_place_url(@place), :notice => t("helpers.messages.destroy", :model_name => Video.model_name.human)
		 else
			  redirect_to admin_place_url(@place), :alert => t("helpers.messages.error")
		 end
	end

	private
	def get_place
		 @place = Place.find params[:place_id]
	end
end
