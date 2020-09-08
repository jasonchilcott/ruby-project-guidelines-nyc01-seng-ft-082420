class CreatingDrinks < ActiveRecord::Migration[6.0]
  def change
    create_table :drinks do |t|
      t.string :name
      t.integer :user_id
      t.boolean :alcoholic
    end
  end
end
