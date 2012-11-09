class Admin::InfosController < Admin::ApplicationController

	load_and_authorize_resource :area
	load_and_authorize_resource :through => :area

	helper_method :permission
  before_filter :find_parent_model
  
	def new
    @info = @area.infos.new
	end

	def create
    @info = @area.infos.new params[:info]
	  if @info.save
		  redirect_to admin_area_url(@area), :notice => t("helpers.messages.new", :model_name => Info.model_name.human)
	  else
		  render :new
	  end
	end

	def edit
	end

	def update
    if @info.update_attributes params[:info]
      redirect_to admin_area_url(@area), :notice => t("helpers.messages.edit", :model_name => Info.model_name.human)
    else
      render :edit
    end
	end

	def destroy
		if @info.destroy
		  redirect_to admin_area_url(@area), :notice => t("helpers.messages.destroy", :model_name => Info.model_name.human)
  	else
		  redirect_to admin_area_url(@area), :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Info.name, "permission.controllers.admin.infos"
  end
  def find_parent_model
    @area = Area.find params[:area_id]
    @model = @area.areable_type.constantize.find @area.areable_id
  end
end
