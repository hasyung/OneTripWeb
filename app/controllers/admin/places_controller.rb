class Admin::PlacesController < Admin::ApplicationController

	def index
		@places = Place.page(params[:page]).per(Setting.admin_AlbumPageSize).created_desc
	end

	def new
		@place = Place.new
	end

	def create
		@place = Place.new params[:place]
		if @place.save
			respond_to do |format|
				format.html { redirect_to :admin_places, :notice => t("helpers.messages.new", :model_name => Place.model_name.human) }
				format.js
			end
		else
			respond_to do |format|
				format.html { render :new }
				format.js
			end
		end
	end

	def edit
		@place = Place.find params[:id]
	end

	def update
		@place = Place.find params[:id]
    if @place.update_attributes params[:place]
    	respond_to do |format|
	      format.html { redirect_to :admin_places, :notice => t("helpers.messages.edit", :model_name => Place.model_name.human) }
	      format.js
	    end
    else
    	respond_to do |format|
	      format.html { render :action => "edit" }
	      format.js
	    end
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

end
