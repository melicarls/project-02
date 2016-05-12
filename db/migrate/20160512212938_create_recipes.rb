class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :author
      t.string :image
      t.string :directions

      t.timestamps null: false
    end
  end
end
