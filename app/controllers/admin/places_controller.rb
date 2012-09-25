class Admin::PlacesController < Admin::ApplicationController

	load_and_authorize_resource

	helper_method :permission

	def index
		@places = @places.page(params[:page]).per(Setting.admin_AlbumPageSize).created_desc
	end

	def show
		@infos = @place.infos.order_desc.created_desc
		@videos = @place.videos.order_desc
		@articles = @place.articles.order_desc.created_desc
		@audios = @place.audios.order_desc.created_desc
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
  
 def search
		 if params[:place][:name].blank?
			  redirect_to :admin_places, :alert => t("helpers.messages.search_error")
			  return
		 else
		   @places = @places.search_name(params[:place][:name]).page(params[:page]).per(Setting.admin_PageSize)
		 end
   render :index
	end

	private
	def self.permission
  	return Place.name, "permission.controllers.admin.places"
  end

end
