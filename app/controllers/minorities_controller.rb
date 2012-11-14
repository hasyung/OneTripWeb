class MinoritiesController < ApplicationController
  def show
    @model = Minority.find params[:url]
    @areas = @model.areas.includes(:area_category, :videos, :audios, :articles, :infos, :images).order_asc
  end
end
