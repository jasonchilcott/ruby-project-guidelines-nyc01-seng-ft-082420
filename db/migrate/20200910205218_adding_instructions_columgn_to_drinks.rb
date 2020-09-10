class AddingInstructionsColumgnToDrinks < ActiveRecord::Migration[6.0]
  def change
    add_column :drinks, :instructions, :string
  end
end
