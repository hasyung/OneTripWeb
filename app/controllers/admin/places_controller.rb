class Admin::PlacesController < Admin::ApplicationController

	load_and_authorize_resource

	helper_method :permission

	def index
		@places = @places.page(params[:page]).per(Setting.admin_AlbumPageSize).created_desc
	end

	def show
		@areas = @place.areas.includes(:area_category).page(params[:page]).per(8).order_asc.created_desc
	end

	def new
		
	end

	def create
		if @place.save
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Place.model_name.human)
		else
			render :new
		end
	end

	def edit
		
	end

	def update
    if @place.update_attributes params[:place]
    	redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Place.model_name.human)
    else
    	render :action => "edit"
    end
	end

	def destroy
    if @place.destroy
      redirect_to :admin_places, :notice => t("helpers.messages.destroy", :model_name => Place.model_name.human)
    else
      redirect_to :admin_places, :alert => t("helpers.messages.error")
    end
	end
  
  def destroies
		if params[:place_ids].blank?
			return redirect_to :admin_places,
												 :alert => t("helpers.messages.selected_error",
												 							:model_name => Place.model_name.human)
		end
		if Place.destroy(params[:place_ids])
			redirect_to :admin_places, 
									:notice => t("helpers.messages.destroy_multiple", 
																:count => params[:place_ids].size,
																:model_name => Place.model_name.human)
		else
			redirect_to :admin_places, :alert => t("helpers.messages.notices.error")
		end
	end
  
 def search
		if params[:place][:name].blank?
		  redirect_to :admin_places, :alert => t("helpers.messages.search_error")
		  return
	  else
		  @places = @places.search_name(params[:place][:name]).page(params[:page]).per(Setting.admin_PageSize)
		end
   render :index
	end

	def publish
		@place.status = params[:status].to_s.to_sym
		if @place.save
			if @place.publish?
				redirect_to :admin_places, :notice => t("helpers.messages.publish")
			else
				redirect_to :admin_places, :notice => t("helpers.messages.draft")
			end
		else
			redirect_to :admin_places, :alert => t("helpers.messages.error")
		end
	end

	private
	def self.permission
  	return Place.name, "permission.controllers.admin.places"
  end

end
