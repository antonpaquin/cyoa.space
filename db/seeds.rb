# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

adventure = Adventure.create(
  title: 'Magic Items',
  css: "/*TODO*/",
  set: '{"points":3}',
  verify: '{"points":">=0"}',
  description: "I'm trying to implement something super simple"
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

def makePick(name)
  Pick.create(
    pick:name,
  	title:"Magic " + name,
  	content:'{"description":"It\'s a magic '+name+'","img_1":"'+name+'.png"}',
  	only_if:'{"points":">0"}',
	  sets:'{"points":"-1"}',
    picklayout_id:1
  )
end
makePick("duck")
makePick("hat")
makePick("pen")
makePick("ring")
