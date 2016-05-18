module RecipesHelper

  require 'date'

  def get_recipes(ingredient_arr)
    @ingredients = Ingredient.all
    #Start with an empty array of potential recipes
    recipes_arr = []
    #Iterate through all of the selected ingredients
    ingredient_arr.each do |ingredient|
      # Need to decide whether the ingredient should be searched in the db or in the api
      # If there is an ingredient object and it's either never been searched or it was searched more than a month ago
      # Make an API call
      if !(ingredient[:searched]) || (Time.now - ingredient[:last_searched]) > 2592000
        # # Make sure to mark the ingredient as searched
        Ingredient.find_by(name: ingredient.name).update({"searched": true, "last_searched": Time.now})
        # Get recipe results from Yummly
        output = search_yummly(ingredient[:name])
        output.each do |el|
          # If the recipe isn't a duplicate from an earlier search, push it into options
          if !recipes_arr.include?(el)
            recipes_arr.push(el)
          end
        end
      # If there's an ingredient object and it's been searched recently, search the DB
      else
        recipes = ingredient.recipes.flatten
        recipes.each do |el|
          if !recipes_arr.include?(el)
            # Push the found recipe into the array of recipes, assuming it's not already in there from an earlier search
            recipes_arr.push(el)
          end
        end
      end
    end
    # Return an array of the acceptable recipes, after making sure that too many things aren't missing
    get_acceptable_recipes(recipes_arr, ingredient_arr)
  end


  def get_acceptable_recipes(recipes, ingredients)
    recipe_options = []
    recipes.each do |maybe_recipe|
      maybe_recipe.missing_ingredients = []
      # Start counting the number of missing ingredients for this specific recipe
      missing_ingredients = 0
      maybe_recipe.ingredients.each do |maybe_ingredient|
        # Look at each of the recipe's ingredients and check whether it is in the user's search
        is_possible_ingredient = ingredients.include?(maybe_ingredient)
        if !is_possible_ingredient
          # If it isn't in the user's pantry, increment the number of missing things
          missing_ingredients += 1
          # Push the ingredient into the recipe's missing ingredients
          maybe_recipe.missing_ingredients.push(maybe_ingredient)
        end
        # If the ingredient being checked was the last one in the ingredient array and the number of missing ingredients
        # is smaller than 3, that recipe was valid and should be pushed to the array of recipes to be returned
        if maybe_ingredient == maybe_recipe.ingredients.last && !(missing_ingredients >= 3)
          recipe_options.push(maybe_recipe)
        end
      end
    end
    recipe_options
  end

  # Method to call if an ingredient hasn't been pulled from the API already
  def search_yummly(ingredient_name)
    #Start with an empty array of results to be returned for that ingredient
    maybe_recipes = []
    # Get all of the recipes containing the ingredient from Yummly
    # API config requires photos of the recipe and that the search term ingredient be on the ingredients list
    results = HTTParty.get("http://api.yummly.com/v1/api/recipes?_app_id="+ENV['APP_ID']+"&_app_key="+ENV['API_KEY']+"&q="+ingredient_name+"&requirePictures=true&allowedIngredient[]="+ingredient_name)
    # Iterate through all of the results from Yummly
    results["matches"].each do |result|
      # If a recipe with the same name isn't already in the database, make a new one
      if !Recipe.find_by(title: result["recipeName"])
        temp = Recipe.new({
                      title: result["recipeName"],
                      author: result["sourceDisplayName"],
                      image: result["imageUrlsBySize"]["90"],
                      directions: "www.yummly.com/recipe/"+result["id"]})
      # Go through all of the result's ingredients
        result["ingredients"].each do |ingred|
          # Sanitize the ingredient name, making it more likely that there will be a match for it in our db
          # If we have an ingredient object for it, link that ingredient to the recipe
          temp_name = sanitize_ingredient(ingred)
          temp_i = Ingredient.find_by(name: temp_name)
          if temp_i
            # If there is a match for that ingredient, push it into the recipe's ingredients array
            temp.ingredients.push(temp_i)
          end
        end
        # Save the recipe and push it into the array of options to be returned
        temp.save
        maybe_recipes << temp
      end
    end
    # Return an array of recipe objects (which have been stored in the DB) containing the searched ingredient
    maybe_recipes
  end

  #Accepts a search term and tries to find a searchable version by comparing it with the database
  def sanitize_ingredient(ingredient)
    # Catch-all for types of pasta
    if ingredient.include?('penne') || ingredient.include?('spaghetti') || ingredient.include?('fettuccini') || ingredient.include?('rigatoni') || ingredient.include?('farfalle') || ingredient.include?('linguini')
      return 'pasta'
    # If the ingredient is plural, singularize it
    elsif ingredient.pluralize == ingredient
      ingredient = ingredient.singularize
    end
    # Search through all ingredients and look for an ingredient that includes the substring
    @ingredients.each do |i|
      # If an ingredient includes the substring, return the db version of the ingredient name
      if i.name.include?(ingredient)
        return i.name
      end
    end
    # If no matches were found, divide the ingredient into individual words
    ingredient_arr = ingredient.split(' ')
    # Search all ingredients for each word and push the ingredient that matches that word into an ingredients_arr
    matches_found =[]
    ingredient_arr.each do |i_piece|
      @ingredients.each do |i|
        if i.name.include?(i_piece)
          # Push any matches into an array of matches
          if !matches_found.include?(i.name)
            matches_found << i.name
          end
        end
      end
    end
    # If there was only one match found, assume that the search was successfull and return that match
    return matches_found[0] if matches_found.length == 1
    # If there were multiple or 0 matches found for that ingredient (ie the words could be found in multiple ingredients)
    # Return the original search term. The search was unreliable.
    ingredient
  end

end
