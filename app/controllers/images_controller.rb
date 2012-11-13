class ImagesController < ApplicationController
  def show
    @image = Images.find params[:id]
    @area = @image.area
    @model = @area.areable_type.constantize.find @area.areable_id
  end
end
