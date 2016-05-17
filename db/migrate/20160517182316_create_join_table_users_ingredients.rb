class CreateJoinTableUsersIngredients < ActiveRecord::Migration
  def change
    create_join_table :users, :ingredients do |t|
      # t.index [:user_id, :ingredient_id]
      # t.index [:ingredient_id, :user_id]
    end
  end
end
