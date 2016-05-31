# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

password = "administrator"
salt = (0...8).map { (1 + rand(254)).chr }.join.force_encoding('UTF-8')
hash = Digest::SHA256.digest(salt + password).force_encoding('UTF-8')
account = Account.create!(
  name: 'Webmin',
  pass_hash: hash,
  usergroup: 0,
  salt: salt
)

adventure = Adventure.create(
  title: 'Magic Items',
  css: "/*TODO*/",
  set: '{"points":3}',
  verify: '{"points":">=0"}',
  description: "I'm trying to implement something super simple",
  playcount: 0,
  stagecount: 1,
  rating: 5,
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
    ',
  title: 'Main',
  adventure_id: adventure.id
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
    ',
  title: 'Magic thingy',
  adventure_id: adventure.id
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
