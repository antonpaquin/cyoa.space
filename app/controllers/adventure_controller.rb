class AdventureController < ApplicationController
  def get
    @adventure = Adventure.find(id=params[:id])
    @advId = params[:id]
    render layout: 'headerbar'
  end

  def all
  end
end
