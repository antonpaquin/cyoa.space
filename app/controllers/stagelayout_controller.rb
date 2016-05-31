class StagelayoutController < ApplicationController
  include ApplicationHelper

  def edit
    begin
      @stagelayout = Stagelayout.find(params[:id])
      @model = @stagelayout
      @adventure = @stagelayout.adventure
      @validFields = ['html','title']
      @field, @old, @inputtype = doEdit(@adventure, @stagelayout, params, @validFields)
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
