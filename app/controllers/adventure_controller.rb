class AdventureController < ApplicationController
  def get
    @adventure = Adventure.find(id=params[:id])
  end

  def all
  end

  def edit
    if ( #Short circuit; if anything decides to render, it returns false and is therefore the last thing called
    getAndVerifyAdventure(params[:id]) &&
    verifyAuthentication(session[:power], session[:userId])
    getAndVerifyModel(params[:model]) &&
    getAndVerifyModelId(params[:modelid]) &&
    getAndVerifyField(params[:field])
    )
      determineFieldInputType()
      render 'editfield'
      return
    end
  end

  def change
  end

  def search
    @results = Adventure.where("title like ?", "%#{params[:query]}%")
  end

  private
  def getAndVerifyAdventure(adventure)
    @adventure = Adventure.find(adventure)
    #First, make sure we operate on a valid adventure
    if (@adventure==nil)
      @message = "No such adventure exists"
      render 'error'
      return false
    end
    return true
  end

  def verifyAuthentication(power, uid)
    #User is authed if they are the author, or have admin or dev level power
    if (power == 2 and @adventure.account != uid)
      @message = "You don't have the privilege to edit that adventure"
      render 'error'
      return false
    end
    @id = @adventure.id
    return true
  end

  def getAndVerifyModel(model)
    #If we don't have a model, start the edit process to select model
    if (model == nil)
      render 'edithome'
      return false
    end
    #Make sure the model is valid
    if (not ["adventure","stage","pick","image","stagelayout","picklayout"].include?(model))
      @message="Invalid model"
      render 'error'
      return false
    end
    @model = model
    return true
  end

  def getAndVerifyModelId(modelid)
    #If we need to get a modelid, get it
    if (modelid == nil)
      if (@model == "stage")
        render 'choosestage'
        return false
      elsif (@model == "pick")
        render 'choosepick'
        return false
      end
    #else next code block

    #If we have a modelid, make sure it belongs to the adventure
    else
      if (@model == "stage")
        if (not @adventure.stages.ids.include?(modelid))
          @message="Stage doesn't belong to adventure"
          render 'error'
          return false
        end
      elsif (@model == "pick")
        if (not @adventure.picks.ids.include?(modelid))
          @message="Choice doesn't belong to adventure"
          render 'error'
          return false
        end
      elsif (@model == "stagelayout")
        if not (@adventure.stagelayouts.ids.include?(modelid))
          @message="Stage layout doesn't belong to adventure"
          render 'error'
          return false
        end
      elsif (@model == "picklayout")
        if not (@adventure.picklayouts.ids.include?(modelid))
          @message="Pick layout doesn't belong to adventure"
          render 'error'
          return false
        end
      end
    end
    @modelid = modelid
    return true
  end

  def getAndVerifyField(field)
    #Check which field we need, and what input type
    if (field==nil)
      if (@model=="adventure")
        render 'editadventure'
        return false
      elsif (@model=="stage")
        render 'editstage'
        return false
      elsif (@model=="pick")
        render 'editpick'
        return false
      elsif (@model=="image")
        render 'editimage'
        return false
      elsif (params[:model]=="stagelayout")
        @field = 'html'
        @old = Stagelayout.find(@modelid).html
        render 'editfield'
        return false
      elsif (params[:model]=="picklayout")
        @field='html'
        @old=Picklayout.find(@modelid).html
        render 'editfield'
        return false
      end
    #else go to next block

    #Make sure field is appropriate for the model
    else
      if (@model=="adventure")
        if (not ["css","set","verify","title","description","public"].include?(field))
          @message="Invalid field"
          render 'error'
          return false
        else
          @old = @adventure[field]
        end
      elsif (@model=="stage")
        if (not ["title","stagelayout_id","order","content"].include?(field))
          @message="Invalid field"
          render 'error'
          return false
        else
          @old = Stage.find(@modelid)[field]
        end
      elsif (@model=="pick")
        if (not ["pick","title","content","only_if","sets","picklayout_id","stage_id"].include?(field))
          @message="Invalid field"
          render 'error'
          return false
        else
          @old = Pick.find(@modelid)[field]
        end
      end
    end
    @field = field
    return true
  end

  def determineFieldInputType()
    @inputtype = {"css" => "textarea",
      "set" => "textarea",
      "verify" => "textarea",
      "title" => "text",
      "description" => "textarea",
      "public" => "checkbox",
      "html" => "textarea",
      "pick" => "text",
      "title" => "text",
      "content" => "textarea",
      "only_if" => "textarea",
      "sets" => "textarea",
      "picklayout_id" => "number",
      "stage_id" => "number",
      "stagelayout_id" => "number",
      "order" => "number"}[@field]
    return true
  end
end
