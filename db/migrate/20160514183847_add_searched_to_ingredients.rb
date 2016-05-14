class AddSearchedToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :searched, :boolean, :default => false
  end
end
