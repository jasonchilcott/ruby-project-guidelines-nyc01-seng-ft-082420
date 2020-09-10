
# require '..lib/app/models/user.rb'
# will need to require access to app/models here

$prompt = TTY::Prompt.new

def log_in_prompt
  choices = ['log in', 'sign up']
  action = $prompt.multi_select("What would you like to do?", choices, required: true)
    if action == ['log in']
      log_in
    elsif action == ['sign up']
      sign_up
    else
      #catch if user doesn't answer
    end
end
  
def log_in 
  puts 'logging in...'
end

def sign_up 
  puts 'signing up'
  result = $prompt.collect do
    key(:name).ask("Name:")
    key(:email_address).ask("Email:")
    key(:password).mask("Password:")
  end

  binding.pry
end

log_in_prompt