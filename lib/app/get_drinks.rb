require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class GetDrinks

  # def initialize()
  #   # will need to pass through some sort of argument to add to url base here.
  # end


  # this will have to be a url base eventually, for now it is fixed
  URL = 'https://www.thecocktaildb.com/api/json/v2/9973533/random.php'

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

  def get_drink_with_instructions
    #currently works with four ingredients, no more, no less
    drinks_hash = JSON.parse(self.get_drinks)
    drink_name = drinks_hash["drinks"][0]["strDrink"]
    drink_instructions = drinks_hash["drinks"][0]["strInstructions"]
    ing1 = drinks_hash["drinks"][0]["strIngredient1"]
    ing2 = drinks_hash["drinks"][0]["strIngredient2"]
    ing3 = drinks_hash["drinks"][0]["strIngredient3"]
    ing4 = drinks_hash["drinks"][0]["strIngredient4"]
    meas1 = drinks_hash["drinks"][0]["strMeasure1"]
    meas2 = drinks_hash["drinks"][0]["strMeasure2"]
    meas3 = drinks_hash["drinks"][0]["strMeasure3"]
    meas4 = drinks_hash["drinks"][0]["strMeasure4"]
    "#{drink_name}: \n#{ing1}: #{meas1}\n#{ing2}: #{meas2}\n#{ing3}: #{meas3}\n#{ing4}: #{meas4}\n#{drink_instructions}"
    #binding.pry
  end

  def save_drink_to_favorites

  end

  def remove_drink_from_favorites

  end
end



## this code is to quickly check your endpoint and hash interation ##


#drinks = GetDrinks.new
#puts drinks.get_drink_with_instructions