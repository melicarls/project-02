class AddMissingIngredientsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :missing_ingredients, :string, array: true, default: []
  end
end
