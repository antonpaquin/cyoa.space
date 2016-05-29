# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

account = Account.create!(
  name: 'Ataraxia',
  pass_hash: '\xA73\xFF_\x1D/X\xBEP\xD87\xE5\x11n\x8B\x06DT\xC1\x14\xBC\x8F\x96Q\x99\xF3-{\x82d\xFBc',
  usergroup: 0,
  salt: '#*$%888'
)

adventure = Adventure.create(
  title: 'Magic Items',
  css: "/*TODO*/",
  set: '{"points":3}',
  verify: '{"points":">=0"}',
  description: "I'm trying to implement something super simple",
  playcount: 0,
  stagecount: 1,
  rating: 5.1,
  ratecount: 1,
  favorites: 0,
  account_id: account.id,
  public: true
  )

stagelayout = Stagelayout.create(
  html: '
    <h1>Magic something something</h1>
    <p>Pick three</p>
    $picks
    <p class="nextButton">Done</p>
    '
  )

stage = Stage.create(
  title: "Main",
  content: '{"picks":["duck","hat","ring","pen"]}',
  adventure_id: adventure.id,
  stagelayout_id: stagelayout.id,
  order:1
  )

picklayout = Picklayout.create(
  html: '
    <div class="pick">
      <h1>$title</h1>
      <img $img_1/>
      <p>$description</p>
    </div>
    '
  )

define_singleton_method("makePick") do |name|
  Pick.create(
    pick:name,
  	title:"Magic " + name,
  	content:'{"description":"It\'s a magic '+name+'","img_1":"'+name+'.png"}',
  	only_if:'{"points":">0"}',
	  sets:'{"points":"-1"}',
    picklayout_id:picklayout.id,
    stage_id:stage.id
  )
end

makePick("duck")
makePick("hat")
makePick("pen")
makePick("ring")
