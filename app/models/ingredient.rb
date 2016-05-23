class Ingredient < ActiveRecord::Base
  has_many :ingredient_recipes
  has_many :recipes, through: :ingredient_recipes, dependent: :destroy
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :ingredient_recipes

  #TODO: no validations? :( -jc

end
