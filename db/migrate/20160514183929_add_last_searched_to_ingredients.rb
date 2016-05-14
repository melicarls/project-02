class AddLastSearchedToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :last_searched, :datetime
  end
end
