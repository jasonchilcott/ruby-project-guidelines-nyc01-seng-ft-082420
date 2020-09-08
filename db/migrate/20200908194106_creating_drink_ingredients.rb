class CreatingDrinkIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :drink_ingredients do |t|
      t.integer :drink_id
      t.integer :ingredient_id
    end
  end
end
