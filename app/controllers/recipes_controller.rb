class RecipesController < ApplicationController

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

  def edit

  end

  def update

  end

private

  def recipe_params
    params.require(:recipe).permit(:title, :author, :directions)
  end

end
