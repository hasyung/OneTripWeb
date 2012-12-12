class MinoritiesController < ApplicationController
  def show
    @model = Minority.find params[:id]
    @areas = @model.areas.includes(:area_category, :videos, :audios, :articles, :infos, :images).order_asc
    if !@model.publish?
      raise ActiveRecord::RecordNotFound
    end
  end
end
