class RecipesController < ApplicationController

  @@basics = ['water', 'salt', 'pepper', 'olive oil', 'vegetable oil', 'flour', 'sugar']

  def search
    @ingredients = Ingredient.all
    @search_terms = []
    @pantry = @search_terms + @@basics
    render :search
  end


  def index
    @ingredients = Ingredient.all
    @ingred_search = []
    if params[:ingredient] == nil
      flash[:error] = "Sorry, you can't make something out of nothing. Go grocery shopping and try again."
      redirect_to search_recipes_path
      return
    end
    param_ids = (params[:ingredient][:ingredient_index])
    param_ids.each do |num|
      @ingred_search << @ingredients[(num.to_i)-1]
    end
    @recipes = get_recipes(@ingred_search, @@basics)
    render :index
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
