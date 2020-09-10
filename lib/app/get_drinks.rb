require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class GetDrinks

  # def initialize()
  #   # will need to pass through some sort of argument to add to url base here.
  # end


  # this will have to be a url base eventually, for now it is fixed
  URL = 'https://www.thecocktaildb.com/api/json/v1/1/random.php'

  def get_drinks
    uri = URI.parse(URL)
    response = Net::HTTP.get_response(uri)
    # JSON.parse(response.body)
    response.body
  end

  def get_drink_id
    puts 'getting drink ID #:'
    drinks_hash = JSON.parse(self.get_drinks)
    drinks_hash["drinks"][0]['idDrink']
    # binding.pry
  end

  def get_drink_name
    # puts 'getting drink Name:'
    drinks_hash = JSON.parse(self.get_drinks)
    drinks_hash["drinks"][0]["strDrink"]
    #binding.pry
  end

  def get_drink_instructions
    
    drinks_hash = JSON.parse(self.get_drinks)
    drink_name = drinks_hash["drinks"][0]["strDrink"]
    drink_instructions = drinks_hash["drinks"][0]["strInstructions"]
    "#{drink_name} \n #{drink_instructions}"
    #binding.pry
  end

end



## this code is to quickly check your endpoint and hash interation ##


drinks = GetDrinks.new
puts drinks.get_drink_instructions