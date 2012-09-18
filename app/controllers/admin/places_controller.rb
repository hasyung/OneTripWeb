class Admin::PlacesController < Admin::ApplicationController

	def index
		@places = Place.page(params[:page]).per(Setting.admin_AlbumPageSize).created_desc
	end

	def show
		@place = Place.find params[:id]
		@infos = @place.infos.order_desc.created_desc
		@narrates = @place.audios.narrates.order_desc.created_desc
		@article_travels = @place.articles.all_travels.order_desc.created_desc
		@article_recommends = @place.articles.recommends.order_desc.created_desc
	end

	def new
		@place = Place.new
	end

	def create
		@place = Place.new params[:place]
		if @place.save
			redirect_to admin_place_url(@place), :notice => t("helpers.messages.new", :model_name => Place.model_name.human)
		else
			render :new
		end
	end

	def edit
		@place = Place.find params[:id]
	end

	def update
		@place = Place.find params[:id]
    if @place.update_attributes params[:place]
    	redirect_to admin_place_url(@place), :notice => t("helpers.messages.edit", :model_name => Place.model_name.human)
    else
    	render :action => "edit"
    end
	end

	def destroy
		@place = Place.find params[:id]
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
		   @places = Place.search_name(params[:place][:name]).page(params[:page]).per(Setting.admin_PageSize)
		 end
   render :index
	end

end
