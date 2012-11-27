class Admin::ImagesController < Admin::ApplicationController
  
 	load_and_authorize_resource :area
	load_and_authorize_resource :through => :area
 	
 	helper_method :permission
  before_filter :find_parent_model

	def new
    if !@area.area_category.decide_purview(Image)
      redirect_to admin_area_url(@area)
    end
    @image = @area.images.new
	end

	def create
    if !@area.area_category.decide_purview(Image)
      redirect_to admin_area_url(@area)
    end
    @image = @area.images.new params[:image]
		if @image.save
		  redirect_to admin_area_url(@area), :notice => t("helpers.messages.new", :model_name => Image.model_name.human)
	  else
		  render :new
	  end
	end

	def edit
    if !@area.area_category.decide_purview(Image)
      redirect_to admin_area_url(@area)
    end
	end

	def update
    if !@area.area_category.decide_purview(Image)
      redirect_to admin_area_url(@area)
    end
   if @image.update_attributes params[:image]
     redirect_to admin_area_url(@area), :notice => t("helpers.messages.edit", :model_name => Image.model_name.human)
   else
     render :edit
   end
	end

	def destroy
		if @image.destroy
		  redirect_to admin_area_url(@area), :notice => t("helpers.messages.destroy", :model_name => Image.model_name.human)
		else
		  redirect_to admin_area_url(@area), :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Image.name, "permission.controllers.admin.images"
  end
  
  def find_parent_model
    @area = Area.find params[:area_id]
    @model = @area.areable_type.constantize.find @area.areable_id
  end
end
