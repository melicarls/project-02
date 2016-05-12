class RecipesController < ApplicationController




















  def search
    @ingredients = Ingredient.all
    render :search
  end


end
