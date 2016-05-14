module RecipesHelper

  def get_recipes(ingredient_arr, basics)
    p "Looking for recipes with these ingredients", ingredient_arr
    #Start with an empty array of potential recipes
    recipes_arr = []
    p "Starting recipe array", recipes_arr
    #Iterate through all of the selected ingredients
    ingredient_arr.each do |ingredient|
      p "Looking at this ingredient", ingredient
      # Need to decide whether the ingredient should be searched in the db or in the api
      # Find the ingredient object
      ingredient_obj = Ingredient.find_by(name: ingredient)
      p "Got an ingredient object", ingredient_obj
      # If there is an ingredient object and it's either never been searched or it was searched more than a month ago
      # Query the API
      if ingredient_obj && ( !ingredient_obj[:searched] || (Datetime.now - ingredient_obj[:last_searched]) > 30 )
        p "An API call is about to be made!"
        # Make sure to mark the ingredient as searched
        ingredient_obj[:searched] = true
        ingredient_obj[:last_searched] = Datetime.now
        # Get recipe results from Yummly
        output = search_yummly(ingredient)
        output.each do |el|
          # If the recipe isn't a duplicate from an earlier search, push it into options
          if !recipes_arr.include?(el)
            recipes_arr.push(el)
          end
        end
      else
        # If there's an ingredient object and it's been searched recently, search the DB
        recipes = ingredient.recipes.flatten
        recipes.each do |el|
          p "Here's the element", el
          if !recipes_arr.include?(el)
            # Push the found recipe into the array of recipes, assuming it's not already in there from an earlier search
            recipes_arr.push(el)
          end
        end
      end
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
    p "SEARCHING YUMMLY"
      maybe_recipes = []
      # Get all of the recipes containing the ingredient from Yummly
      results_arr = HTTParty.get("http://api.yummly.com/v1/api/recipes?_app_id="+ENV[APP_ID]+"&_app_key="+ENV[API_KEY]+"&q="+ingredient_name+"&requirePictures=true")
      p "Here are the api call results", results_arr
      # Iterate through all of the results from Yummly
      results_arr.matches.each do |result|
        p "Adding this recipe to the database", result
        # If a recipe with the same name isn't already in the database, make a new one
        if !Recipe.find_by(title: result[:recipeName])
          temp = Recipe.new({
                        title: result[:recipeName],
                        author: result[:sourceDisplayName],
                        image: result[:smallImageUrls][0],
                        directions: "www.yummly.com/recipe/"+result[:id]})
        # Go through all of the result ingredients
          result[:ingredients].each do |ingred|
        # If we have an ingredient object for it, link that ingredient to the recipe
            temp_i = Ingredient.find_by(name: ingred)
            if temp_i
              temp.ingredients.push(temp_i)
            end
          end
          # Save the recipe and push it into the array of options to be returned
          temp.save
          maybe_recipes << temp
        end
      end
      # Return an array of recipe objects containing the searched ingredient
      maybe_recipes
  end

end
