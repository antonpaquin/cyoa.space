class AdventureController < ApplicationController
  def get
    @adventure = Adventure.find(id=params[:id])
  end

  def all
  end

  def edit
  end

  def images
  end
end
