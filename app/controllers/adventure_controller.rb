class AdventureController < ApplicationController
  def get
    @adventure = Adventure.find(id=params[:id])
    @advId = params[:id]
  end

  def all
  end
end
