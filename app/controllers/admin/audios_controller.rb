class Admin::AudiosController < Admin::ApplicationController

	load_and_authorize_resource :place
	load_and_authorize_resource :through => :place

	helper_method :permission

	def new
		
	end

	def create
		if @audio.save
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Audio.model_name.human)
		else
			render :new
		end
	end

	def edit
		
	end

	def update
    if @audio.update_attributes params[:audio]
    	redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Audio.model_name.human)
    else
    	render :edit
    end
	end

	def destroy
		if @audio.destroy
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.destroy", :model_name => Audio.model_name.human)
		else
			redirect_to admin_place_url(@place), :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Audio.name, "permission.controllers.admin.audios"
  end
end
