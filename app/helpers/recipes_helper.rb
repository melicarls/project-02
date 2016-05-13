module RecipesHelper

  def get_recipes(ingredient_arr)
    recipes_arr = []
    p "Starting recipe array", recipes_arr
    ingredient_arr.each do |searching|
      p "Looking at this ingredient", searching
      ingredient = Ingredient.find_by_name(searching)
      # Query join table to get all recipes with that ingredient
      recipes = ingredient.recipes.flatten
      p "Found these recipes", recipes
      recipes.each do |el|
        p "Here's the element", el
        if !recipes_arr.include?(el)
          # Push the found recipe into the array of recipes, assuming it's not already in there from an earlier search
          recipes_arr.push(el)
        end
      end
      # Add those recipes to the larger list of recipe options
      p "Recipe array", recipes_arr
    end
    p "Here's the recipe array after checking all ingredients", recipes_arr
    # Return an array of the acceptable ingredients
    get_acceptable_recipes(recipes_arr, ingredient_arr)
  end


  def get_acceptable_recipes(recipes, ingredients)
    recipe_options = []
    p "Each recipe's ingredients need to be in this array", ingredients
    recipes.each do |maybe_recipe|
      maybe_recipe.missing_ingredients = []
      p "Checking this recipe", maybe_recipe
      p "Here is it's ingredients list", maybe_recipe.ingredients
      # Start counting the number of missing ingredients for this specific recipe
      missing_ingredients = 0
      maybe_recipe.ingredients.each do |maybe_ingredient|
        p "Looking at this ingredient", maybe_ingredient.name
        possible_ingredient = ingredients.include?(maybe_ingredient.name)
        p "This is in the user's pantry:", possible_ingredient
        if !possible_ingredient
          maybe_recipe.missing_ingredients.push(maybe_ingredient)
          missing_ingredients += 1
          p maybe_ingredient, "wasn't in the user's pantry. Missing ingredient count is now", missing_ingredients
        end
        if maybe_ingredient == maybe_recipe.ingredients.last && !(missing_ingredients >= 3)
          p maybe_recipe.title, "was a valid option!"
          p missing_ingredients, "many things are missing though"
          recipe_options.push(maybe_recipe)
        else
          p "The user doesn't have enough stuff to make", maybe_recipe.title
        end
      end
    end
    recipe_options
  end

end

get_recipes(["tortilla", "cheese"])
