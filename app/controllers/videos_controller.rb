class VideosController < ApplicationController
   def show
    @video = Video.find params[:id]
    @area = @video.area
    @model = @area.areable_type.constantize.find @area.areable_id
  end
end
