class Admin::AreasController < Admin::ApplicationController
  load_and_authorize_resource

	helper_method :permission
  
  before_filter :find_parent_model

	def index
		@areas = @areas.page(params[:page]).per(Setting.admin_AlbumPageSize).created_desc
	end

	def show
    @model = @area.areable_type.constantize.find @area.areable_id
	end

	def new
    @area = @model.areas.new
	end

	def create
    @area = @model.areas.new params[:area]
		if @area.save
			redirect_to generation_area_path(@area), :notice => t("helpers.messages.new", :model_name => Area.model_name.human)
		else
			render :new
		end
	end

	def edit
    @model = @area.areable_type.constantize.find @area.areable_id
	end

	def update
    @model = @area.areable_type.constantize.find @area.areable_id
    if @area.update_attributes params[:area]
    	redirect_to generation_area_path(@area), :notice => t("helpers.messages.edit", :model_name => Area.model_name.human)
    else
    	render :action => "edit"
    end
	end

	def destroy
    if @area.destroy
      redirect_to generation_area_path(@area), :notice => t("helpers.messages.destroy", :model_name => Area.model_name.human)
    else
      redirect_to generation_area_path(@area), :alert => t("helpers.messages.error")
    end
	end

	private
	def self.permission
  	return Area.name, "permission.controllers.admin.areas"
  end
  
  def find_parent_model
    @model = Place.find params[:place_id] if !params[:place_id].blank?
    @model = Minority.find params[:monority_id] if !params[:monority_id].blank?
  end

end
