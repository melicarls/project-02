class CreateIngredientRecipe < ActiveRecord::Migration
  def change
    create_table :ingredient_recipes do |t|
      t.references :ingredient
      t.references :recipe

      t.timestamps null: false
    end
  end
end
