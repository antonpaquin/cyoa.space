class AdventureController < ApplicationController
  def get
    @adventure = Adventure.find(id=params[:id])
  end

  def all
  end

  def edit
    begin
      @adventure = getAndVerifyAdventure(params[:id])
      verifyAuthentication(@adventure, session[:power], session[:userId])

      @field = params[:field]
      @validFields = ["css","set","verify","title","description","public"]
      verifyField(@field, @validFields)
      @inputtype = determineFieldInputType(@field)

      if (params[:method] == "post")
        if (@inputtype == "checkbox")
          params[:newvalue] = (if (params[:newvalue] == nil) then false else true end)
        end
        @adventure[@field] = params[:newvalue]
        @adventure.save()
      end

      @old = getField(@adventure, @field)
      render 'editfield'
    rescue IndexError, SecurityError => message
      #User is unauthorized, or has an invalid field, or something really error-y
      @message = message
      render 'error'
    rescue ArgumentError => message
      #There's no field, give them the selection dialog
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

  private
  def getAndVerifyAdventure(aid)
    adventure = Adventure.find(aid)
    if (adventure==nil)
      raise IndexError, "No such adventure exists"
    end
    return adventure
  end

  def verifyAuthentication(adventure, power, uid)
    #User is authed if they are the author, or have admin or dev level power
    if (power == 2 and adventure.account != uid)
      raise SecurityError, "You don't have the privilege to edit that adventure"
    end
  end

  def verifyField(field, validFields)
    if (field==nil)
      raise ArgumentError, "No field"
    else
      if (not validFields.include?(field))
        raise IndexError, "Invalid field"
      end
    end
  end

  def getField(adventure, field)
    return adventure[field]
  end

  def determineFieldInputType(field)
    return {
      "css" => "textarea",
      "set" => "textarea",
      "verify" => "textarea",
      "title" => "text",
      "description" => "textarea",
      "public" => "checkbox"}[field]
  end
end
