class RecipesController < ApplicationController

  def index

  end

  def new
    @recipe = Recipe.new
    render :new
  end

  def create

  end
  
end
