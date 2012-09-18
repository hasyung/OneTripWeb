class Admin::PicturesController < Admin::ApplicationController

	def index
		@pictures = Picture.page(params[:page]).per(Setting.admin_PhotoPageSize).created_desc
	end

	def new
		@picture = Picture.new
		@pictures = Picture.page(params[:page]).per(Setting.admin_PhotoPageSize).created_desc
	end

	def create
		@picture = Picture.new params[:picture]
		if @picture.save
			respond_to do |format|
				format.html {
					render :json => [@picture.to_jq_upload].to_json,
								 :content_type => "text/html",
								 :layout => :false
				}
				format.json {
					render :json => [@picture.to_jq_upload].to_json
				}
			end
		else
			render :json => [{ :error => @picture.errors }]
		end
	end

	def destroy
		
	end

end
