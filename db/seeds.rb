
require 'faker'

User.create!( :username => "tasteofhome",
              :email => "admin@tasteofhome.com",
              :password => "password",
              :owner => false
)

def associate_stores_and_foods_to_list(list, food, location)
  parameters = { term: food, category_filter: "food,restaurants", limit: 1}
  results = Yelp.client.search(location, parameters)

  stores = results.businesses.map do |business|
    {name: business.name, address: business.location.display_address.push(business.location.country_code).join(", "), phone: business.display_phone, neighborhoods: business.location.neighborhoods, description: business.categories.flatten.join(", "), longitude: business.location.coordinate.longitude, latitude: business.location.coordinate.latitude, img_url: business.image_url, rating_url: business.rating_img_url, yelp_id: business.id, longitude_delta: results.region.span.longitude_delta, latitude_delta: results.region.span.latitude_delta, review_count: business.review_count}
  end
  stores.each do |store|
    list.stores << Store.where(yelp_id: store[:yelp_id]).first_or_create(store)
  end
end

# User.delete_all
# Tag.delete_all

users = 20.times.map do
  User.create!( :username => Faker::Internet.user_name,
                :email => Faker::Internet.email,
                :password => "password",
                :owner => false
    )
end

Tag.create!(name: 'British')
Tag.create!(name: 'Senegal')
Tag.create!(name: 'candy')
Tag.create!(name: 'spices')
Tag.create!(name: 'Vietnam')
Tag.create!(name: 'French')
Tag.create!(name: 'bread')
Tag.create!(name: 'Brazil')
Tag.create!(name: 'New Zealand')

minnesota = List.create!(user_id: "1", name: 'Taste of Minnesota', image_filename: 'minnesota_flag.gif', description: "It's the home of warm welcomes and cold winters, of lutefisk and Lizzo, of 10,000 lakes and the late, great Prince. Here's a selection of places where we've found our favorite Minnesota foods in NYC, including cheese curds, Swedish meatballs, Juicy Lucy burgers, wild rice soup, and dessert bars.")

associate_stores_and_foods_to_list(minnesota, "sugarburg", 11211)
associate_stores_and_foods_to_list(minnesota, "smorgas chef", 10005)
associate_stores_and_foods_to_list(minnesota, "whitmans", 11211)
associate_stores_and_foods_to_list(minnesota, "peasant stock", 11211)
associate_stores_and_foods_to_list(minnesota, "buttercup bake shop", 10001)

london = List.create!(user_id: "1", name: 'Taste of London', image_filename: 'uk_food_flag.jpg', description: "It's no surprise that residents of the British capital feel at home in New York. The two cities have much in common, including top-tier theater, vast subway systems, and, of course, astronomical housing costs. Like New York, London is also a city of rich food traditions, many of which have made their way across the pond. Here's where you can experience the Big Smoke in the Big Apple, with foods like Walkers crisps, fish and chips, curry, the full English breakfast, and Ribena")

associate_stores_and_foods_to_list(london, "myers of keswick", 10001)
associate_stores_and_foods_to_list(london, "greenpoint fish and lobster", 11211)
associate_stores_and_foods_to_list(london, "brick lane curry", 10002)
associate_stores_and_foods_to_list(london, "gordon bennett", 11249)
associate_stores_and_foods_to_list(london, "butcher block", 11104)

upstate = List.create!(user_id: "1", name: 'Taste of Upstate New York', image_filename: 'buffalo_postcard.jpg', description: "As residents of America's largest and most crowded city, we sometimes forget that there's quite a lot of New York that exists beyond the reaches of our subways and commuter trains. Upstate New York is home to approximately six million people with traditions distinctly different from those found downstate. They drink Labatt Blue instead of Bud Light. They cheer for the Bills instead of the Giants. And when they leave the region, they miss these unique foods, and food establishments, most of all: Loganberry, Beef on Weck, Utica Greens, Garbage Plate, and Wegmans.")

associate_stores_and_foods_to_list(upstate, "buffalos famous", 11216)
associate_stores_and_foods_to_list(upstate, "two door tavern", 11211)
associate_stores_and_foods_to_list(upstate, "lulu and po", 11205)
associate_stores_and_foods_to_list(upstate, "little town nyc", 10014)
associate_stores_and_foods_to_list(upstate, "wegmans", 10011)

kiwi = List.create!(user_id: "1", name: 'Taste of New Zealand', image_filename: 'new_zealand_flag.jpg', description: "Most Americans know it as the place where 'Lord of the Rings' was filmed. But New Zealand is far more than a stand-in for Middle Earth. It's one of the world's friendliest, most beautiful, and most unique places, with a cuisine whose fresh flavors combine Maori and British traditions with Mediterranean, Asian, and Australian influences to produce dishes like Marmite, meat pie, mutton chops, pavlova, and Anzac biscuits.")

associate_stores_and_foods_to_list(kiwi, "kiwiana", 11215)
associate_stores_and_foods_to_list(kiwi, "dub pies", 11215)
associate_stores_and_foods_to_list(kiwi, "nelson blue", 10005)
associate_stores_and_foods_to_list(kiwi, "public new zealand", 10012)
associate_stores_and_foods_to_list(kiwi, "the musket room", 10012)

montreal = List.create!(user_id: "1", name: 'Taste of Montreal', image_filename: 'montreal_flag.jpg', description: "It's only six hours' drive from New York City, but it's a world away. Montreal is a city of two official languages and many different personalities. Its food reflects its singular, youthful, multicultural atmosphere, with dishes like poutine, the Coffee Crisp bar, Montreal-style bagels, smoked meat, and maple taffy.")

associate_stores_and_foods_to_list(montreal, "perfect potato", 11217)
associate_stores_and_foods_to_list(montreal, "economy candy", 10002)
associate_stores_and_foods_to_list(montreal, "black seed bagel", 10012)
associate_stores_and_foods_to_list(montreal, "mile end", 10016)
associate_stores_and_foods_to_list(montreal, "corner of vermont", 11215)

bologna = List.create!(user_id: "1", name: 'Taste of Bologna', image_filename: 'italy_food_flag.jpg', description: "Bologna is a medieval Northern Italian city of red brick towers and porticoed sidewalks that is also home to the world's oldest university, the University of Bologna, founded in 1088. It is the capital of the Emilia-Romagna region, considered the culinary heart of Italy and known for such dishes as tagliatelle al ragu, tortellini in brodo, bollito misto, zuppa inglese, and mortadella.")

associate_stores_and_foods_to_list(bologna, "al di la", 11215)
associate_stores_and_foods_to_list(bologna, "osteria morini", 10012)
associate_stores_and_foods_to_list(bologna, "supper restaurant", 10009)
associate_stores_and_foods_to_list(bologna, "lanterna di vittorio", 10012)
associate_stores_and_foods_to_list(bologna, "eataly", 10016)

issan = List.create!(user_id: "1", name: 'Taste of Issan', image_filename: 'thailand_food_flag.jpg', description: "Separated from the rest of Thailand by mountains, the Isan region of Thailand has developed a cuisine all its own that remains distinctive from the central Thai dishes that are generally associated with Thai food in New York City. You won't find pad thai or massaman curry, but you will find strong flavors, fresh ingredients, and lots of sourness and spice in dishes like larb, green papaya salad, Issan sausage, sticky rice, and gai yang.")

associate_stores_and_foods_to_list(issan, "somtum der", 10009)
associate_stores_and_foods_to_list(issan, "zabb elee", 11372)
associate_stores_and_foods_to_list(issan, "sripraphai", 11377)
associate_stores_and_foods_to_list(issan, "larb ubol", 10018)
associate_stores_and_foods_to_list(issan, "pho thai lao", 07607)

chicago = List.create!(user_id: "1", name: 'Taste of Chicago', image_filename: 'chicago_flag.gif', description: "It may be the Second City, but, as anyone who has lived there will tell you, it's first in food. Perhaps no American city is more culinarily innovative and has put its own spin on more iconic dishes than the Midwest Metropolis. As generations of Chicagoans have moved across the country and around the world, they have brought their signature foods with them. Even here in New York, where there is a profound difference of opinion about pizza styles and whether ketchup belongs on a hot dog (spoiler alert: it doesn't) Chicagoans can find the foods that they miss most: deep dish pizza, Italian beef sandwiches, Chicago-style hot dogs, the jibarito, and Malort.")

associate_stores_and_foods_to_list(chicago, "emmetts", 10012)
associate_stores_and_foods_to_list(chicago, "hanks juicy beef", 11101)
associate_stores_and_foods_to_list(chicago, "the landing", 11201)
associate_stores_and_foods_to_list(chicago, "pasteles y algo mas", 07660)
associate_stores_and_foods_to_list(chicago, "the leadbelly", 10002)
