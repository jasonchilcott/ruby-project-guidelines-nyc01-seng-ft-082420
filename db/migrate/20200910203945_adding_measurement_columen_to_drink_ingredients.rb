class AddingMeasurementColumenToDrinkIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :drink_ingredients, :measurement, :string
  end
end
