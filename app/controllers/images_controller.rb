class ImagesController < ApplicationController
  def show
    @image = Image.find params[:id]
    @area = @image.area
    @model = @area.areable_type.constantize.find @area.areable_id
  end
end
