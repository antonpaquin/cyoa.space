class AdventureController < ApplicationController
  include ApplicationHelper

  def get
    @adventure = Adventure.find(id=params[:id])
  end

  def all
  end

  def import
    if (params[:method] == 'post')
      doZipUpload params[:zipfile]
      verifyFileTree
      createAdventureFromFile
    else
    end
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

  private

  def doZipUpload(file)
    require 'zip'
    fname = Rails.root.join('public','advImports',session[:userId].to_s).to_s[0..-1]
    File.open(fname + '.zip', 'wb') do |f|
      f.write(file.read)
    end
    Zip::File.open(fname + '.zip') do |zipfile|
      zipfile.each do |f|
        fpath = File.join(fname, f.name)
        zipfile.extract(f, fpath) unless File.exists?(fpath)
      end
    end
  end

  def createAdventureFromFile
    path = Rails.root.join('public','advImports',session[:userId].to_s).to_s + '/'
    adventure, path = importLoadAdventure(path)
    pickLayouts, pickLayoutIds = importLoadPickLayouts(path, adventure)
    stageLayouts, stageLayoutIds = importLoadStageLayouts(path, adventure)
    stages, picks = importLoadStagesAndPicks(path, adventure, stageLayoutIds, pickLayoutIds)
  #rescue => e #Actually I like errors
  #  @message = 'Import failed, ' + e.message
  #  #Destroy everything
  #  render 'error'
  end

  def importLoadAdventure(path)
    advTitle = Dir[path + '*'][0][path.length..-1]
    path = path + advTitle + '/'
    advCss = importRead(path + 'css.css')
    advVerify = importRead(path + 'verify.json')
    advSet = importRead(path + 'set.json')
    advDescription = importRead(path + 'description.txt')
    advStageCount = Dir[path + 'Stages/*'].length
    advPublic = (importRead(path + 'public.txt')=='true')

    return Adventure.create(
      title: advTitle,
      css: advCss,
      set: advSet,
      verify: advVerify,
      description: advDescription,
      stagecount: advStageCount,
      public: advPublic,

      playcount: 0,
      rating: 5,
      ratecount: 1,
      favorites: 0,
      account_id: session[:userId]), path
  end

  def importLoadStagesAndPicks(path, adventure, pickLayoutIds, stageLayoutIds)
    stageOrder = []
    File.readlines(path + 'stageOrder.txt').each do |l|
      stageOrder.push(l.strip)
    end
    stage_path = path + 'Stages/'
    Dir[stage_path + '*'].each do |stageTitle|
      stageTitle = stageTitle[stage_path.length..-1]
      sp = stage_path + stageTitle + '/'
      stageContent = importRead(sp + 'content.json')
      stageLayout = stageLayoutIds[importRead(sp + 'layout.txt')]
      stageOrderN = stageOrder.index(stageTitle) + 1
      stage = Stage.create(
        title: stageTitle,
        content: stageContent,
        stagelayout_id: stageLayout,
        order: stageOrderN,
        adventure_id: adventure.id)
      pick_path = sp + 'Choices/'
      Dir[pick_path + '*'].each do |pickName|
        pickName = pickName[pick_path.length..-1]
        pp = pick_path + pickName + '/'
        pickTitle = importRead(pp + 'title.txt')
        pickContent = importRead(pp + 'content.json')
        pickOnlyIf = importRead(pp + 'only_if.json')
        pickSets = importRead(pp + 'sets.json')
        pickLayout = pickLayoutIds[importRead(pp + 'layout.txt')]
        Pick.create(
          pick: pickName,
          title: pickTitle,
          content: pickContent,
          only_if: pickOnlyIf,
          sets: pickSets,
          picklayout_id: pickLayout,
          stage_id: stage.id)
      end
    end
  end

  def importLoadStageLayouts(path, adventure)
    stagelayout_path = path + 'Stage Layouts/'
    stagelayoutIds = {}
    stageLayouts = []
    Dir[stagelayout_path + '*'].each do |layout|
      slName = layout[stagelayout_path.length..-6]
      slHtml = importRead(layout)
      stageLayout = Stagelayout.create(
        title: slName,
        html: slHtml,
        adventure_id: adventure.id)
      stagelayoutIds[slName] = stageLayout.id
      stageLayouts.push(stageLayout)
    end
    return stageLayouts, stagelayoutIds
  end

  def importLoadPickLayouts(path, adventure)
    picklayout_path = path + 'Choice Layouts/'
    picklayoutIds = {}
    pickLayouts = []
    Dir[picklayout_path + '*'].each do |layout|
      plName = layout[picklayout_path.length..-6]
      plHtml = importRead(layout)
      pickLayout = Picklayout.create(
        title: plName,
        html: plHtml,
        adventure_id: adventure.id)
      picklayoutIds[plName] = pickLayout.id
      pickLayouts.push(pickLayout)
    end
    return pickLayouts, picklayoutIds
  end

  def importRead(filename)
    File.open(filename, 'r') do |f|
      return f.read.strip
    end
  end

  def verifyFileTree
    return true #Fuckit #TODO
  end
end
