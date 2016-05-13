class AddQuantityToIngredientsRecipes < ActiveRecord::Migration
  def change
    add_column :ingredients_recipes, :quantity, :string
  end
end
