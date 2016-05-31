class AdventureController < ApplicationController
  include ApplicationHelper

  def get
    @adventure = Adventure.find(id=params[:id])
  end

  def all
  end

  def edit
    begin
      @adventure = Adventure.find(params[:id])
      @model = @adventure
      @validFields = ["css","set","verify","title","description","public"]
      @field, @old, @inputtype = doEdit(@adventure, @adventure, params, @validFields)
      render 'editfield'
    rescue ActiveRecord::RecordNotFound
      @message = 'No such adventure exists'
      render 'error'
    rescue ArgumentError => message
      render 'edit'
    end
  end

  def delete
  end

  def new
  end

  def search
    @results = Adventure.where("title like ?", "%#{params[:query]}%")
  end
end
