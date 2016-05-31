class PickController < ApplicationController
  include ApplicationHelper

  def edit
    begin
      @pick = Pick.find(params[:id])
      @model = @pick
      @adventure = @pick.stage.adventure
      @validFields = ['pick','title','content','only_if','sets','picklayout_id','stage_id']
      @field, @old, @inputtype = doEdit(@adventure, @pick, params, @validFields)
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
