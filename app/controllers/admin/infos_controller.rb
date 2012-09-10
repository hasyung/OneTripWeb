class Admin::InfosController < Admin::ApplicationController

	before_filter :get_place

	def new
		@info = Info.new
	end

	def create
		@info = Info.new params[:info]
		@info.place = @place
		if @info.save
			respond_to do |format|
				format.js
			end
		else
			respond_to do |format|
				format.js
			end
		end
	end

	def edit
		@info = Info.find params[:id]
	end

	def update
		@info = Info.find params[:id]
    if @info.update_attributes params[:info]
    	respond_to do |format|
	      format.js
	    end
    else
    	respond_to do |format|
	      format.js
	    end
    end
	end

	def destroy
		@info = Info.find params[:id]
    @info.destroy
	end

	private
	def get_place
		@place = Place.find params[:place_id]
	end

end
