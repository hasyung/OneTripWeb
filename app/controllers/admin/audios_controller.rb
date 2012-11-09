class Admin::AudiosController < Admin::ApplicationController

	load_and_authorize_resource :area
	load_and_authorize_resource :through => :area

	helper_method :permission
  before_filter :find_parent_model
	
  def new
		@audio = @area.audios.new
	end

	def create
    @audio = @area.audios.new params[:audio]
		if @audio.save
			redirect_to admin_area_url(@area), :notice => t("helpers.messages.new", :model_name => Audio.model_name.human)
		else
			render :new
		end
	end

	def edit
		
	end

	def update
    if @audio.update_attributes params[:audio]
    	redirect_to admin_area_url(@area), :notice => t("helpers.messages.edit", :model_name => Audio.model_name.human)
    else
    	render :edit
    end
	end

	def destroy
		if @audio.destroy
			redirect_to admin_area_url(@area), :notice => t("helpers.messages.destroy", :model_name => Audio.model_name.human)
		else
			redirect_to admin_area_url(@area), :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Audio.name, "permission.controllers.admin.audios"
  end
  def find_parent_model
    @area = Area.find params[:area_id]
    @model = @area.areable_type.constantize.find @area.areable_id
  end
end
