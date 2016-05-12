class RecipesController < ApplicationController

  def search
    @ingredients = Ingredient.all
    @search_terms = []
    @basics = ['water', 'salt', 'pepper', 'olive oil', 'vegetable oil', 'flour', 'sugar']
    @pantry = @search_terms + @basics
    render :search
  end


  def index

  end

  def new
    @recipe = Recipe.new
    render :new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "Successfully created Recipe"
      redirect_to new_recipe_path
    else
      flash[:error] = @recipe.errors.full_messages.join(", ")
    end
  end

private

  def recipe_params
    params.require(:recipe).permit(:title, :author, :directions)
  end

end
