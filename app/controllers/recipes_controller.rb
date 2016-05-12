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

  def show
    @recipe = Recipe.find_by_id params[:id]
    render :show
  end

  def new
    @recipe = Recipe.new
    render :new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "Successfully created Recipe"
      redirect_to recipe_path(@recipe)
    else
      flash[:error] = @recipe.errors.full_messages.join(", ")
    end
  end

  def edit
    @recipe = Recipe.find_by_id params[:id]
    render :edit
  end

  def update
    @recipe = Recipe.find_by_id params[:id]
      if @recipe.update(recipe_params)
        flash[:notice] = "Successfully updated Recipe"
        redirect_to recipe_path
      else
        flash[:error] = @recipe.errors.full_messages.join(", ")
      end
  end


  def destroy
    recipe = Recipe.find_by_id(params[:id])
    if recipe.destroy
      redirect_to search_recipes_path
    end
  end

private

  def recipe_params
    params.require(:recipe).permit(:title, :author, :directions)
  end

end
