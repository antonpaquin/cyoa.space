class PicklayoutController < ApplicationController
  include ApplicationHelper

  def edit
    begin
      @picklayout = Picklayout.find(params[:id])
      @model = @picklayout
      @adventure = @picklayout.adventure
      @validFields = ['html','title']
      @field, @old, @inputtype = doEdit(@adventure, @picklayout, params, @validFields)
      render 'adventure/editfield'
    rescue ActiveRecord::RecordNotFound
      @message = 'No such choice exists'
      render 'error'
    rescue ArgumentError => message
      render 'edit'
    end
  end

  def new
  end

  def delete
  end
end
