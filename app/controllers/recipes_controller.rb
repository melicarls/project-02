class RecipesController < ApplicationController

  # TODO: Please include a brief comment on this method -jc
  def search
    @ingredients = Ingredient.all
    render :search
  end

  # TODO: Please include a brief comment on this method -jc
  def index
    @ingredients = Ingredient.all
    @ingred_search = []

    # TODO: Map this to avoid going through it multiple times
    # TODO: Consider extracting the entire key_arr parser into a private method that simply returns the array.  Ir array is empty then redirect. -jc
    # TODO: START OF EXTRACTED METHOD
    key_arr = params.keys
    key_arr.delete_if { |k| k.to_i == 0}
    if key_arr == []
      flash[:error] = "Sorry, you can't make something out of nothing. Go grocery shopping and try again."
      redirect_to search_recipes_path
    # TODO: END OF EXTRACTED METHOD
    # TODO: Why does this return need to return? -jc
      return
    end

    # TODO: The below code can be truncated thusly:
    # current_user.ingredients.delete_all if current_user

    if current_user
    # TODO: Please remove all debugging code from production versions -jc
      p "Here is current user", current_user
      current_user.ingredients.delete_all
    end

    key_arr.each do |num|
      #TODO: In your key_arr parser method, change the num to integers instead of here
      #TODO: You are calling the database twice with the same id, consider extracting this to a variable
      # found_ingredient = Ingredient.find(num)
      @ingred_search << Ingredient.find(num.to_i)
      #TODO: Change the below code block to:
      # current_user.ingredients << found_ingredient if current_user
      if current_user
        current_user.ingredients << Ingredient.find(num.to_i)
      end
    end
    #TODO: good extraction! :) -jc
    @recipes = get_recipes(@ingred_search)
    render :index
  end

  # TODO: Please include a brief comment on this method -jc
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
