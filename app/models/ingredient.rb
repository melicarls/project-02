class Ingredient < ActiveRecord::Base
  has_many :ingredient_recipes
  has_many :recipes, through: :ingredient_recipes, dependent: :destroy
  accepts_nested_attributes_for :ingredient_recipes
end
