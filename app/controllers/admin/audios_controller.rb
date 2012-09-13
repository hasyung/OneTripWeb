class Admin::AudiosController < Admin::ApplicationController

	before_filter :get_place

	def new
		@audio = Audio.new
	end

	def create
		@audio = @place.audios.new params[:audio]
		if @audio.save
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Audio.model_name.human)
		else
			render :new
		end
	end

	def edit
		@audio = @place.audios.find params[:id]
	end

	def update
		@audio = @place.audios.find params[:id]
    if @audio.update_attributes params[:place]
    	redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Audio.model_name.human)
    else
    	render :edit
    end
	end

	def destroy
		@audio = @place.audios.find params[:id]
		if @audio.destroy
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.destroy", :model_name => Audio.model_name.human)
		else
			redirect_to admin_place_url(@place), :alert => t("helpers.messages.error")
		end
	end

	private
	def get_place
		@place = Place.find params[:place_id]
	end
end
