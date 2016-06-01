class StageController < ApplicationController
  include ApplicationHelper

  def get
    #Params: advId, stageNum
    stage = Stage.where(adventure_id: params[:advId], order: params[:stageNum]).take
    content = stage.content
    @html = stage.stagelayout.html
    json = JSON.parse(content)
    json.each do |key, data|
      if data.class == Array
        s = ''
        data.each do |name|
          s = s + getPick(name, stage.id) + "\n"
        end
        json[key] = s
      end
    end
    @html = replaceVariables(@html, json)
    render layout: false
  end

  def edit
    begin
      @stage = Stage.find(params[:id])
      @model = @stage
      @adventure = @model.adventure
      @validFields = ['title','content','order','stagelayout_id']
      @field, @old, @inputtype = doEdit(@adventure, @stage, params, @validFields)
      render 'adventure/editfield'
    rescue ActiveRecord::RecordNotFound
      @message = 'No such stage exists'
      render 'error'
    rescue ArgumentError => message
      render 'edit'
    end
  end

  def new
  end

  def delete
  end

  private
  def getPick(name, sid)
    pick = Pick.where(stage_id: sid, pick: name).take
    html = pick.picklayout.html
    json = JSON.parse(pick.content)
    if json['title'] == nil
      json['title'] = pick.title
    end
    html = replaceVariables(html, json)
    return html
  end

  def replaceVariables(html, replace)
    #Translates strings like
    #html = "This is a string with var $foo string string string"
    #And replace = {'foo' => 'bar'}
    #Into "This is a string with var bar string string string"
    replace['$'] = '$'
    fixImageVars!(replace)
    p = 0
    while true
      p = html.index('$',p)
      if p==nil
        break
      end
      p+=1
      s = html.index(/[^a-zA-Z0-9_]/,p)
      if (s==nil)
        s = html.length
      end
      varname = html[p, s-p]
      html = html[0, p-1] + replace[varname] + html[s..-1]
    end
    return html
  end

  def fixImageVars!(replace)
    replace.each do |key, value|
      if (key[0..2]=='img')
        image = Image.where(adventure_id: params[:advId], name: value).take
        replace[key] = "src=\""+image.image.url+"\""
      end
    end
  end
end
