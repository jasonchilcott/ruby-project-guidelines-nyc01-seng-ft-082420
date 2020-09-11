require "tty-prompt"
require 'pry'

class CocktailApp
  attr_reader :user
  def run
    welcome
    log_in_or_sign_up
    log_in
    main_menu
  end

  private

  # methods down here

  $prompt = TTY::Prompt.new

  def welcome
    puts "Welcome to the Cocktail App"
    sleep(1.5)
  end

  def log_in_or_sign_up
    choices = ['log in', 'sign up']
    action = $prompt.multi_select("What would you like to do? ", choices, required: true, min: 1, max: 1)
      if action == ['sign up']
        sign_up
      elsif action == ['log in']
      else
        abort "Bye"
      end
  end
    
  def sign_up 
    puts 'signing up'
    new_user = $prompt.collect do
      key(:name).ask("Name:", required: true)
      key(:email_address).ask("Email:", required: true){ |q| q.validate :email }
      key(:password).mask("Password:", required: true)
    end
    User.create(name: new_user[:name], email: new_user[:email_address], password: new_user[:password])
    puts "Thanks for creating an account #{new_user[:name]} \nPlease log in "
  end

  def validate_password
    count = 0
    while count < 3
      validate_pw = $prompt.mask('Password:', required: true)
      if validate_pw != @user.password
        puts "That is not a valid password "
        count += 1
      else return @user
      end
    end
    @user = nil
    abort "Goodbye"
  end

  def log_in 
    find_user = $prompt.ask("Name:", required: true)

    if User.find_by(name: find_user)
      @user = User.find_by(name: find_user)
      validate_password
    else
      sleep(0.5)
      puts "We don't have you on file, please sign up"
      sleep(0.5)
      sign_up
      log_in
    end
  end

  def main_menu
    # drinks = GetDrinks.new
    # puts "have random #{drinks.get_drink_name} on us..."
    choices = ['Search for drinks', 'Add your own drink', 'Favorites', 'Exit']
    main_menu_response = $prompt.multi_select("Alright #{@user.name}, what's next? ", choices, required: true, max: 1)
    if main_menu_response == ['Search for drinks']
      puts "Let's go find you a drink!"
    elsif main_menu_response == ['Add your own drink']
      # puts "Let's add your own creation!"
      add_user_drink
    elsif main_menu_response == ['Favorites']
      # puts "Let's checkout your favorites"
      favorites
    elsif main_menu_response == ['Exit']
      puts "Goodbye"
      abort
    end
  end

  def find_drink_by_ingredients
    # "Please enter an igredient"
    # would you like to enter another (repeat until they say no)
    
    ## unsure how to structure api call here ##
    ## how many ingredients can we search by - can we get the api to do all the work here? ###
    
    #builds an array of 10 drinks

    #calls drink_names_menu(array_of_10_drinks)

    
    #############might need this code #############
    #  new_ingredient = GetDrinks.new(ingredient)
    #  new_ingredient
  end
  
  def drink_names_menu(drinks)
    # turns drinks array into menu options

    
    # calls find_drink_by_name()
  end
  
  def find_drink_by_name
    # displays drink
    # find_drink = GetDrinks.new('drink_name')
    # find_drink.get_drink_with_instructions
    # with question prompt at the bottom to return to drink array or main menu
  end

  def add_user_drink
    drink_name = $prompt.ask("What do you want to call your drink?" , required: true)
    new_drink = Drink.create( name: drink_name, user_id: @user.id, alcoholic: true, instructions: nil)
    UserDrink.create(user_id: @user.id, drink_id: new_drink.id)

    is_alcoholic = $prompt.yes?("Does your drink contain alcohol?", required: true)
    if is_alcoholic == false
      new_drink.alcoholic = false
    end
    add_ingredient(new_drink)
    add_instructions(new_drink)
    # review drink - setup with same structure as a normal drink layout
    main_menu
  end

  def add_ingredient(new_drink)
    ingredient = $prompt.ask("Ingredient Name?" , required: true) do |q|
      q.modify :down, :strip
    end
    new_ingredient = Ingredient.find_or_create_by(name: ingredient)
    measurement = $prompt.ask("How much of #{ingredient}?" , required: true) do |q|
      q.modify :down, :strip
    end
    DrinkIngredient.create(drink_id: new_drink.id, ingredient_id: new_ingredient.id,measurement: measurement)
    choices = ["add another ingredient", "I'm done adding ingredients"]
    countinue_adding = $prompt.multi_select("What's next?", choices, required: true, max: 1)
    if countinue_adding == ['add another ingredient'] 
      add_ingredient(new_drink)
    end
  end

  def add_instructions(new_drink)
    instructions = $prompt.ask("Write some instructions for your drink" , required: true) do |q|
      q.modify :down, :strip
    end
    new_drink.instructions = instructions
  end

  def favorites
    # add menu here
    choices = ['Browse Favorites', 'Edit a Favorite', 'Remove a Favorite', 'Back to Main Menu']
    favorites_response = $prompt.multi_select('Favorites: ', choices, required: true, max: 1)
    if favorites_response == ['Browse Favorites']
      # view_favorites
      display_fav_drink
    elsif favorites_response == ['Edit a Favorite']
      edit_favorite
    elsif favorites_response == ['Remove a Favorite']
      remove_favorite
    elsif favorites_response == ['Back to Main Menu']
      main_menu
    end
    # view favs, edit favs, delete a fav
  end
  
  def view_favorites
    favorites = @user.drinks
    fav_array = favorites.map do |f|
      f.name 
    end
    view_favorites_response = $prompt.multi_select("Choose a drink:", fav_array, required: true, max: 1)
    current_drink = Drink.all.filter{|d| d.name == view_favorites_response[0]}
    current_drink = current_drink[0]
    # display_fav_drink(current_drink)
    current_drink 
  end

  def display_fav_drink #(drink)
    # drink = drink[0]
    drink = view_favorites
    puts drink.name
    drink_ingredients = DrinkIngredient.all.filter{|di| di.drink_id == drink.id}
    drink_ingredients.each do | drink_ingred|
      puts "#{drink_ingred.ingredient.name}: #{drink_ingred.measurement}"
    end
    puts drink.instructions
    # press enter to return to view favs
    favorites
  end

  def edit_favorite
    puts "let's edit a fav"

    # favorites
  end

  def remove_favorite
    puts "let's removed a fav"
    remove_drink = view_favorites

    # find UserDrink where drink_id == remove_drink.id
    remove = UserDrink.all.find{|ud| ud.drink_id == remove_drink.id && ud.user_id == @user.id}
    UserDrink.delete(remove.id)

    favorites
  end
end
# binding.pry
