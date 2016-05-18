class RecipesController < ApplicationController


  def search
    @ingredients = Ingredient.all
    render :search
  end


  def index
    @basics = ['water', 'salt', 'pepper', 'olive oil', 'vegetable oil', 'flour', 'sugar']
    @ingredients = Ingredient.all
    @ingred_search = []

    # Map this to avoid going through it multiple times
    key_arr = params.keys
    key_arr.delete_if { |k| k.to_i == 0}
    if current_user
      p "Here is current user", current_user
      current_user.ingredients.delete_all
    end
    if key_arr == []
      flash[:error] = "Sorry, you can't make something out of nothing. Go grocery shopping and try again."
      redirect_to search_recipes_path
      return
    end
    key_arr.each do |num|
      @ingred_search << Ingredient.find(num.to_i)
      if current_user
        current_user.ingredients << Ingredient.find(num.to_i)
      end
    end
    @recipes = get_recipes(@ingred_search, @basics)
    render :index
  end

  def show
    @recipe = Recipe.find_by_id params[:id]
    render :show
  end

  def new
    if current_user
      @ingredients = Ingredient.all
      @recipe = Recipe.new
      render :new
    else
      redirect_to search_recipes_path
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.author = current_user.email
    if @recipe.save
      flash[:notice] = "Successfully created Recipe"
      redirect_to recipe_path(@recipe)
    else
      flash[:error] = @recipe.errors.full_messages.join(", ")
    end
  end

  def edit
    @ingredients = Ingredient.all
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

  def about
    render :about
  end

private

  def recipe_params
    params.require(:recipe).permit(:title, :author, :directions, :searched, :last_searched, :ingredient_recipes_attributes => [:quantity])
  end

end
