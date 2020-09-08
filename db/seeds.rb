Drink.destroy_all
DrinkIngredient.destroy_all
Ingredient.destroy_all
User.destroy_all
UserDrink.destroy_all

gin_tonic = Drink.create(name: "Gin and Tonic", user_id: nil, alcoholic: true)
old = Drink.create(name: "Old Fashioned", user_id: nil, alcoholic: true)
vod_red = Drink.create(name: "Vodka Red Bull", user_id: nil, alcoholic: true)
bloody = Drink.create(name: "Bloody Mary", user_id: nil, alcoholic: true)
virgin_coke = Drink.create(name: "Virgin Coke", user_id: nil, alcoholic: false)


gin = Ingredient.create(name: "Gin")
vodka = Ingredient.create(name: "Vodka")
whiskey = Ingredient.create(name: "Whiskey")
coke = Ingredient.create(name: "Coke")
tonic = Ingredient.create(name: "Tonic")


di1 = DrinkIngredient.create(drink_id: gin_tonic.id, ingredient_id: gin.id)
di6 = DrinkIngredient.create(drink_id: gin_tonic.id, ingredient_id: tonic.id)

di2 = DrinkIngredient.create(drink_id: old.id, ingredient_id: whiskey.id)
di3 = DrinkIngredient.create(drink_id: virgin_coke.id, ingredient_id: coke.id)
di4 = DrinkIngredient.create(drink_id: bloody.id, ingredient_id: vodka.id)
di5 = DrinkIngredient.create(drink_id: vod_red.id, ingredient_id: vodka.id)


doc_venture = User.create(name: "Dr. Venture", email: "dr@venture.com", password: "Hank!!!")
hank = User.create(name: "Hank Venture", email: "hank@venture.com", password: "I'm batman")
monarch = User.create(name: "The Monarch", email: "monarch@theguild.com", password: "Fresca")

ud1 = UserDrink.create(user_id: doc_venture.id, drink_id: gin_tonic.id)
ud2 = UserDrink.create(user_id: doc_venture.id, drink_id: vod_red.id)
ud3 = UserDrink.create(user_id: monarch.id, drink_id: bloody.id)
ud4 = UserDrink.create(user_id: hank.id, drink_id: virgin_coke.id)