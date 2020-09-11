require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class GetDrinks
 
  URL = 'https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?i='

  def get_drinks(ingredients)
    adding = ingredients.split(' ').join(',').capitalize
    url = "#{URL}#{adding}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    # JSON.parse(response.body)
    # response.body
    drinks_hash = JSON.parse(response.body)
    if drinks_hash["drinks"] == "None Found"
      return 'None Found'
    else 
      drinks_hash["drinks"].map{|d| d['strDrink']}

    end
  end

  def get_drink_by_name(name)
    name = name.split(' ').join('_')
    base = 'https://www.thecocktaildb.com/api/json/v1/1/search.php?s='
    url = "#{base}#{name}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    drink_hash = JSON.parse(response.body)
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
  
end

