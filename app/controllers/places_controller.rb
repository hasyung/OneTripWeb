class PlacesController < ApplicationController
  def show
    @model = Place.find params[:id].strip
    if !@model.publish?
      raise ActiveRecord::RecordNotFound
    end
    @areas = @model.areas.includes(:area_category, :videos, :audios, :articles, :infos, :images).order_asc
  end
end
