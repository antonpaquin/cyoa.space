module ApplicationHelper
  def doEdit(adventure, model, params, validFields)
    begin
      verifyAuthentication(adventure, session[:power], session[:userId])

      field = params[:field]
      verifyField(field, validFields)
      inputtype = determineFieldInputType(field)

      if (params[:method] == "post")
        if (inputtype == "checkbox")
          params[:newvalue] = (if (params[:newvalue] == nil) then false else true end)
        end
        model[field] = params[:newvalue]
        model.save()
      end

      old = model[field]
      return field, old, inputtype
    rescue IndexError, SecurityError => message
      #User is unauthorized, or has an invalid field, or something really error-y
      @message = message
      render 'adventure/error'
    end
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

  def determineFieldInputType(field)
    return {"css" => "textarea",
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
            "order" => "number",
            "layout" => "number"}[field]
  end
end
