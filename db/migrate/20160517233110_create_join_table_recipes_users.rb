class CreateJoinTableRecipesUsers < ActiveRecord::Migration
  def change
    create_join_table :recipes, :users do |t|
      # t.index [:recipe_id, :user_id]
      # t.index [:user_id, :recipe_id]
    end
  end
end
