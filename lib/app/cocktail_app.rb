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

def validate_password
  count = 0
  while count < 3
    validate_pw = $prompt.mask('Password', required: true)
    if validate_pw != @user.password
      puts "That is not a valid password"
      count += 1
    else return @user
    end
  end
  @user = nil
  abort "Goodbye"
end

def log_in 
  find_user = $prompt.ask("Name:", required: true)
  # binding.pry

  if User.find_by(name: find_user)
    @user = User.find_by(name: find_user)
    validate_password
  else
    puts "we don't recognize your, please sign up"
    sleep(0.5)
    sign_up
  end

  # find_user = $prompt.collect do
  #   key(:name).ask("Name:", required: true)
  #   key(:password).mask("Password:", required: true)
  # end

  # if find_user[:password] != @user.password
  #   puts "That password is incorrect"
  #   sleep(1)
  #   puts "Please log in again"
  #   log_in
  # end
end

def main_menu
  puts "#{@user.name}"
end


end