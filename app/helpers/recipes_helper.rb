module RecipesHelper

  def get_recipes(ingredient_arr, basics)
    p "Looking for recipes with these ingredients", ingredient_arr
    recipes_arr = []
    p "Starting recipe array", recipes_arr
    ingredient_arr.each do |ingredient|
      p "Looking at this ingredient", ingredient
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
    get_acceptable_recipes(recipes_arr, ingredient_arr, basics)
  end


  def get_acceptable_recipes(recipes, ingredients, basics)
    recipe_options = []
    p "Each recipe's ingredients need to be in this array", ingredients
    p "The basics are these", basics
    ingredients = ingredients + basics
    recipes.each do |maybe_recipe|
      maybe_recipe.missing_ingredients = []
      p "Checking this recipe", maybe_recipe
      p "Here is it's ingredients list", maybe_recipe.ingredients
      # Start counting the number of missing ingredients for this specific recipe
      missing_ingredients = 0
      maybe_recipe.ingredients.each do |maybe_ingredient|
        p "Looking at this ingredient", maybe_ingredient.name
        possible_ingredient = ingredients.include?(maybe_ingredient)
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
        end
      end
    end
    recipe_options
  end


  # Method to call if an ingredient hasn't been pulled from the API already
  def search_yummly(ingredient_name)
    maybe_recipes = []
    results_arr = HTTParty.get("http://api.yummly.com/v1/api/recipes?_app_id="+ENV[APP_ID]+"&_app_key="+ENV[API_KEY]+"&q="+ingredient_name+"&requirePictures=true")
    p "Here are the api call results", results_arr
    results_arr.matches.each do |result|
      p "Adding this recipe to the database", result
      # Check that the recipe isn't already in the DB (names will have to be unique)
      if !Recipe.find_by(title: result[:recipeName])
        temp = Recipe.new({
                      title: result[:recipeName],
                      author: result[:sourceDisplayName],
                      image: result[:smallImageUrls][0],
                      directions: "www.yummly.com/recipe/"+result[:id]})
        result[:ingredients].each do |ingred|
          temp_i = Ingredient.find_by(name: ingred)
          if temp_i
            temp.ingredients.push(temp_i)
          end
        end
        temp.save
        maybe_recipes << temp
      end
    end
    maybe_recipes
  end

end
