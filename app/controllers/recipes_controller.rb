class RecipesController < ApplicationController


  def search
    @ingredients = Ingredient.all
    render :search
  end


  def index
    @ingredients = Ingredient.all
    @ingred_search = []

    # Map this to avoid going through it multiple times
    key_arr = params.keys
    key_arr.delete_if { |k| k.to_i == 0}
    if key_arr == []
      flash[:error] = "Sorry, you can't make something out of nothing. Go grocery shopping and try again."
      redirect_to search_recipes_path
      return
    end
    if current_user
      p "Here is current user", current_user
      current_user.ingredients.delete_all
    end
    key_arr.each do |num|
      @ingred_search << Ingredient.find(num.to_i)
      if current_user
        current_user.ingredients << Ingredient.find(num.to_i)
      end
    end
    @recipes = get_recipes(@ingred_search)
    render :index
  end

  def show
    @recipe = Recipe.find_by_id params[:id]
    if !@recipe
      flash[:error] = "Sorry, we can't find that recipe. Search for another one below!"
      redirect_to search_recipes_path
    else
      render :show
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
