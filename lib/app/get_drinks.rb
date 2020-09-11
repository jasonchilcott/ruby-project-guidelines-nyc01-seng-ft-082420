require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class GetDrinks
  # attr_accessor :ingredients

  # def initialize(ingredients)
  #   @ingredients = ingredients
  # end

  # https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?i=rum,vodka

  URL = 'https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?i='
  # take ingredients and add commas where whitespace is
  # url_extension = @ingredients.split
  
  # this will have to be a url base eventually, for now it is fixed
  # URL = 'https://www.thecocktaildb.com/api/json/v2/9973533/random.php'
  
  def get_drinks(ingredients)
    adding = ingredients.split(' ').join(',').capitalize
    url = "#{URL}#{adding}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    # JSON.parse(response.body)
    # response.body
    drinks_hash = JSON.parse(response.body)
    if drinks_hash["drinks"] = "None Found"
      return 'None Found'
    else drinks_hash["drinks"].map{|d| d['strDrink']}

    end
  end
  
  # def get_drink_names
  #   drinks_hash = JSON.parse(self.get_drinks)
  #   drinks_hash["drinks"].map{|d| d['strDrink']}
  #   # returns array of drink names
  # end

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
  
  def get_drink_by_id(id)
    id_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=#{id}"
    uri = URI.parse(id_url)
    response = Net::HTTP.get_response(uri)
    # JSON.parse(response.body)
    response.body
  end
end

new = GetDrinks.new
puts new.get_drinks('vodka gin rum')
