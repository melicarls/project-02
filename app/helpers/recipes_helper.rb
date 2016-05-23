module RecipesHelper

  require 'date'

  # TODO: Please include a brief comment on this awesome method -jc
  def get_recipes(ingredient_arr)
    @ingredients = Ingredient.all
    recipes_arr = []
    ingredient_arr.each do |ingredient|
      if !(ingredient[:searched]) || (Time.now - ingredient[:last_searched]) > 2592000
        #TODO: Extract this db call to a model method
        Ingredient.find_by(name: ingredient.name).update({"searched": true, "last_searched": Time.now})
        #TODO: thank you for extracting this code to a variable :)
        output = search_yummly(ingredient[:name])
        output.each do |el|
          #TODO: refactor the below code thusly:
          # recipes_arr.push(el) if !recipes_arr.include?(el)
          #  OR
          # extract this action into a private method as it is used below
          if !recipes_arr.include?(el)
            recipes_arr.push(el)
          end
        end
      else
        #TODO: thank you for extracting this code to a variable :)
        recipes = ingredient.recipes.flatten
        recipes.each do |el|
          # TODO: see above (line 16)
          if !recipes_arr.include?(el)
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
      #TODO: missing_ingredients is used two different ways for two different variables. Please consider changing the name.
      missing_ingredients = 0
      maybe_recipe.ingredients.each do |maybe_ingredient|
        #TODO: thank you for extacting this code block to a variable :)
        #TODO: try renaming this to is_not_possible_ingredient and add a bang to the ingredients.include conditional check.  THEN you can write if is_not_possible_ingredient, which reads easier.
        is_possible_ingredient = ingredients.include?(maybe_ingredient)
        if !is_possible_ingredient
          missing_ingredients += 1
          maybe_recipe.missing_ingredients.push(maybe_ingredient)
        end
        #TODO: extract this big conditional into a variable
        #TODO: run a {block} if (conditional) refactor on this.
        if maybe_ingredient == maybe_recipe.ingredients.last && !(missing_ingredients >= 3)
          recipe_options.push(maybe_recipe)
        end
      end
    end
    recipe_options
  end

  # Method to call if an ingredient hasn't been pulled from the API already
  def search_yummly(ingredient_name)
    maybe_recipes = []
    #TODO: extract the api link to a variable.
    #TODO: Also please use string interpolation. This link frigthens me.
    results = HTTParty.get("http://api.yummly.com/v1/api/recipes?_app_id="+ENV['APP_ID']+"&_app_key="+ENV['API_KEY']+"&q="+ingredient_name+"&requirePictures=true&allowedIngredient[]="+ingredient_name)
    results["matches"].each do |result|
      #TODO: extract this db interaction to the model (pass in maybe_recipes, return maybe_recipes)
      if !Recipe.find_by(title: result["recipeName"])
        temp = Recipe.new({
                      title: result["recipeName"],
                      author: result["sourceDisplayName"],
                      image: result["imageUrlsBySize"]["90"],
                      directions: "www.yummly.com/recipe/"+result["id"]})
        result["ingredients"].each do |ingred|
          #TODO: extract this db interaction to the model
          temp_i = Ingredient.find_by(name: sanitize_ingredient(ingred))
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

  #Accepts a search term and tries to find a searchable version by comparing it with the database
  def sanitize_ingredient(ingredient)
    ingredient.downcase!

    #TODO: This could possibly use some refactoring and/or extracting. Maybe an any? method run on an array of pasta types? Worth a google :)
    if ingredient.include?('penne') || ingredient.include?('spaghetti') || ingredient.include?('fettuccini') || ingredient.include?('rigatoni') || ingredient.include?('farfalle') || ingredient.include?('linguini')
      return 'pasta'

    #TODO: woah, awesome!
    elsif ingredient.pluralize == ingredient
      ingredient = ingredient.singularize
    end

    @ingredients.each do |i|
      if i.name.include?(ingredient)
        return i.name
      end
    end
    ingredient_arr = ingredient.split(' ')

    matches_found =[]
    ingredient_arr.each do |i_piece|
      @ingredients.each do |i|
        if i.name.include?(i_piece)
          if !matches_found.include?(i.name)
            matches_found << i.name
          end
        end
      end
    end

    # TODO: Ternaries for the win!
    matches_found.length == 1 ? matches_found[0] : ingredient
  end

end
