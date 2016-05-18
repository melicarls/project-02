class Recipe < ActiveRecord::Base
  has_many :ingredient_recipes
  has_many :ingredients, through: :ingredient_recipes
  accepts_nested_attributes_for :ingredient_recipes
  has_and_belongs_to_many :users
end
