require "tty-prompt"
require 'pry'

class CocktailApp
  attr_reader :user
  def run
    # puts "Cocktail App is running!"
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
    action = $prompt.multi_select("What would you like to do?", choices, required: true)
      if action == ['sign up']
        sign_up
      else
        #catch if user doesn't answer
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
  end

  def log_in 
    # find_user = $prompt.ask("Name:", required: true)

    find_user = $prompt.collect do
      key(:name).ask("Name:", required: true)
      key(:password).mask("Password:", required: true)
    end

    # if false try again or kick to sign up here
    @user = User.find_by(name: find_user[:name])
    if find_user[:password] != @user.password
      puts "That password is incorrect"
      sleep(1)
      puts "Please log in again"
      log_in
    end
  end
  # binding.pry

  def main_menu
    puts "Alright #{@user.name}, what's next"

    drinks = GetDrinks.new
    puts "have random #{drinks.get_drink_name} on us..."

    # multiple choice question here: max: 1
    # 1: Find a drink by indgredient(s)
    # 2: Find a drink by ...
    # 3: Add your own drink
    # 4: Favorites

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
    # question prompts in order
      # 1. add Drink name ( 
        # new_drink = Drink.create(name:'name', user_id: @user.id, alcoholic: true, instructions: nil)
        # UserDrink.create(user_id: @user.id, drink_id: new_drink.id)
        # )
      # 2. Is drink alcoholic (new_drink.alcoholic = 'response')
      # 3. add ingredient multiple input question
        # add ingredient (Ingredient.find_or_create() save ID as a variable)
        # add measurement ()
      # 4. repeat add ingredient or move forward
      # 5. add instructions ( new_drink.instructions = 'response')
      # returns user to main_menu
  end
end