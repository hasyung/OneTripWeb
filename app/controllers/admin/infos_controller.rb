class Admin::InfosController < Admin::ApplicationController

	before_filter :get_place

	def new
		 @info = Info.new
	end

	def create
			@info = @place.infos.new params[:info]
		 if @info.save
			  redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Info.model_name.human)
		 else
			  render :new
		 end
	end

	def edit
		 @info = @place.infos.find params[:id]
	end

	def update
	  @info = @place.infos.find params[:id]
   if @info.update_attributes params[:info]
     redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Info.model_name.human)
   else
     render :edit
   end
	end

	def destroy
		 @info = @place.infos.find params[:id]
		 if @info.destroy
			  redirect_to admin_place_url(@place), :notice => t("helpers.messages.destroy", :model_name => Info.model_name.human)
		 else
			  redirect_to admin_place_url(@place), :alert => t("helpers.messages.error")
		 end
	end

	private
	def get_place
		 @place = Place.find params[:place_id]
	end
end
