class AudiosController < ApplicationController
  def show
    @audio = Audio.find params[:id]
    @area = @audio.area
    @model = @area.areable_type.constantize.find @area.areable_id
    if !@model.publish?
      raise ActiveRecord::RecordNotFound
    end
  end
end
