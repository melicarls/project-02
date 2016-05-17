Ingredient.destroy_all
ingredients = Ingredient.create([
  {name: 'apple'},
  {name: 'artichoke'},
  {name: 'avocado'},
  {name: 'bacon'},
  {name: 'blueberry'},
  {name: 'bread'},
  {name: 'carrot'},
  {name: 'cheese'},
  {name: 'chicken'},
  {name: 'chicken stock'},
  {name: 'couscous'},
  {name: 'egg'},
  {name: 'eggplant'},
  {name: 'ground beef'},
  {name: 'kiwi'},
  {name: 'lettuce'},
  {name: 'mango'},
  {name: 'mushroom'},
  {name: 'noodle'},
  {name: 'quinoa'},
  {name: 'rice'},
  {name: 'sausage'},
  {name: 'spinach'},
  {name: 'strawberry'},
  {name: 'tomato'},
  {name: 'tortilla'},
  {name: 'watermelon'},
  ])

Recipe.destroy_all
recipes = Recipe.create([
  {title: 'Quesadilla', author: 'Katie Wells', image: 'https://c1.staticflickr.com/1/171/477850958_02eff4bd8f.jpg',
    directions:'1. Preheat the broiler. Grease a baking sheet.
      2. Toss the chicken with the fajita seasoning, then spread onto the baking sheet. Place under the broiler and cook until the chicken pieces are no longer pink in the center, about 5 minutes.
      3. Preheat oven to 350 degrees F (175 degrees C).
      4. Heat the oil in a large saucepan over medium heat. Stir in the green bell peppers, red bell peppers, onion, and chicken. Cook and stir until the vegetables have softened, about 10 minutes.
      5. Layer half of each tortilla with the chicken and vegetable mixture, then sprinkle with the Cheddar cheese, bacon bits, and Monterey Jack. Fold the tortillas in half and Place onto a baking sheet.
      6. Bake quesadillas in the preheated oven until the cheeses have melted, about 10 minutes.'},
  {title: 'Mac and Cheese', author: 'Peter Tyson', image: 'https://c2.staticflickr.com/4/3005/3003882006_cdf2da02b9.jpg',
    directions:'1. Cook macaroni according to the package directions. Drain.
      2. In a saucepan, melt butter or margarine over medium heat. Stir in enough flour to make a roux. Add milk to roux slowly, stirring constantly. Stir in cheeses, and cook over low heat until cheese is melted and the sauce is a little thick. Put macaroni in large casserole dish, and pour sauce over macaroni. Stir well.
      3. Melt butter or margarine in a skillet over medium heat. Add breadcrumbs and brown. Spread over the macaroni and cheese to cover. Sprinkle with a little paprika.
      4. Bake at 350 degrees F (175 degrees C) for 30 minutes. Serve.'},
  {title: 'Omelette', author: 'Eriz Ruiz', image: 'https://pixabay.com/static/uploads/photo/2015/05/20/16/11/kitchen-775746_960_720.jpg',
    directions:'1. Whisk egg substitute, Cheddar cheese, Parmesan cheese, salt, black pepper, garlic powder, and red pepper flakes together in a bowl.
      2. Heat olive oil in a nonstick skillet over medium heat; cook and stir mushrooms and onion until tender, 4 to 5 minutes. Add spinach; cook until spinach wilts, 3 to 4 minutes. Pour in egg mixture; swirl pan around to evenly distribute egg mixture. Cook until egg is fully cooked and set in the middle, 5 to 10 minutes. Cut into wedges.'},
  {title: 'Spaghetti', author: 'Cathleen Barry', image: 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Spaghetti_with_Meatballs_(cropped).jpg',
    directions:'1. Heat the olive oil in a large saucepan over medium heat, and cook the onion until lightly brown. Mix in 2 cloves garlic, and cook 1 minute. Stir in crushed tomatoes, tomato paste, water, sugar, 1/2 the oregano, and bay leaf. Season with salt and pepper. Bring to a boil, reduce heat to low, and simmer while preparing meatballs.
      2. In a bowl, mix the ground round, bread crumbs, remaining oregano, remaining garlic, parsley, eggs, and cheese. Season with salt and pepper. Roll into 1 inch balls, and drop into the sauce. Cook 40 minutes in the sauce, or until internal temperature of meatballs reaches a minimum of 160 degrees F (72 degrees C).
      3. Bring a large pot of lightly salted water to a boil, and stir in the spaghetti. Cook 8 to 10 minutes, until al dente, and drain. Serve the meatballs and sauce over the cooked spaghetti.'},
  {title: 'Hamburger', author: 'Travis Black', image: 'https://pixabay.com/static/uploads/photo/2015/09/06/01/10/hamburger-926885_960_720.jpg',
    directions:'1. Preheat an outdoor grill for medium-high heat.
      2. Combine ground sirloin, onion, grill seasoning, liquid smoke, Worcestershire sauce, garlic, adobo sauce, and chipotle pepper in a large bowl. Form the mixture into 6 patties. Season with salt and pepper.
      3. Place burgers on preheated grill and cook until no longer pink in the center. Place a slice of Cheddar cheese on top of each burger one minute before they are ready. Place burgers on buns to serve.'},
  {title: 'BLT', author: 'Daniel Weissbarth', image: 'https://c1.staticflickr.com/3/2251/4513652932_2688d16d1a.jpg',
    directions:'1. Cook the bacon in a large, deep skillet over medium-high heat until evenly browned, about 10 minutes. Drain the bacon slices on a paper towel-lined plate.
      2. Arrange the cooked bacon, lettuce, and tomato slices on one slice of bread. Spread one side of remaining bread slice with the mayonnaise. Bring the two pieces together to make a sandwich.'},
  {title: 'Burrito', author: 'Sam Stromberg', image: 'http://images.media-allrecipes.com/images/55485.jpg',
    directions:'1. Crumble ground beef into a skillet over medium-high heat. Cook and stir until evenly browned. Add onion, and cook until translucent. Drain grease, and season with garlic, cumin, salt and pepper. Stir in the green chilies and refried beans until well blended. Turn off heat, but keep warm.
      2. In a saucepan, combine the chili without beans, tomato soup and enchilada sauce. Mix well, and cook over medium heat until heated through. Turn off heat and keep warm.
      3. Place a warmed tortilla on a plate, and spoon a generous 1/2 cup of the ground beef mixture onto the center. Top with lettuce and tomato to your liking. Roll up tortilla over the filling. Spoon a generous amount of the sauce over the top, and sprinkle with cheese and green onions. Heat in the microwave for 30 seconds, or until cheese is melted. Repeat with remaining tortillas.'},
  {title: 'Chicken Noodle Soup', author: 'Josh Hendricks', image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/Chicken_noodle_soup_(cropped).jpg/871px-Chicken_noodle_soup_(cropped).jpg',
    directions:'1. Bring a large pot of lightly salted water to a boil. Add egg noodles and oil, and boil for 8 minutes, or until tender. Drain, and rinse under cool running water.
      2. In a large saucepan or Dutch oven, combine broth, salt, and poultry seasoning. Bring to a boil. Stir in celery and onion. Reduce heat, cover, and simmer 15 minutes.
      3. In a small bowl, mix cornstarch and water together until cornstarch is completely dissolved. Gradually add to soup, stirring constantly. Stir in noodles and chicken, and heat through.'},
  {title: 'Tacos', author: 'Erica Hagle', image: 'https://upload.wikimedia.org/wikipedia/commons/3/36/Tacos_de_pescado_de_Ensenada..jpg',
    directions:'1. Place chicken breasts into a saucepan and pour in enough water to cover. Place over medium heat, bring to a boil, and simmer until chicken meat is no longer pink, 10 to 12 minutes.
      2. Transfer chicken breasts to a bowl, allow to cool, and shred the chicken meat with 2 forks.
      3. Heat vegetable oil in a small non-stick saucepan over medium heat, and cook and stir onion until translucent, 2 to 3 minutes.
      4. Mix in the shredded chicken, cumin, chili powder, and tomato sauce; bring to a boil.
      5. Reduce heat to low and simmer until chicken is hot and the flavors have blended, about 3 minutes.'},
  {title: 'Chicken Stir Fry', author: 'Zack Dolin', image: 'http://getinspiredeveryday.com/food/wp-content/uploads/sites/5/2015/05/Sweet-Chili-Chicken-Stir-Fry-GI-365-5.jpg',
    directions:'1. Bring rice and water to a boil in a saucepan over high heat. Reduce heat to medium-low, cover, and simmer until rice is tender, and liquid has been absorbed, 20 to 25 minutes.
      2. Combine soy sauce, brown sugar, and corn starch in a small bowl; stir until smooth. Mix ginger, garlic, and red pepper into sauce; coat chicken with marinade and refrigerate for at least 15 minutes.
      3. Heat 1 tablespoon sesame oil in a large skillet over medium-high heat. Cook and stir bell pepper, water chestnuts, broccoli, carrots, and onion until just tender, about 5 minutes. Remove vegetables from skillet and keep warm.
      4. Remove chicken from marinade, reserving liquid. Heat 1 tablespoon sesame oil in skillet over medium-high heat. Cook and stir chicken until slightly pink on the inside, about 2 minutes per side; return vegetables and reserved marinade to skillet. Bring to a boil; cook and stir until chicken is no longer pink in the middle and vegetables are tender, 5 to 7 minutes. Serve over rice.'}
  ])

  ingredients_for_recipes_list =
  [
    [ingredients[3], ingredients[4], ingredients[5]],
    [ingredients[3], ingredients[6]],
    [ingredients[2], ingredients[3], ingredients[7], ingredients[8], ingredients[9], ingredients[12]],
    [ingredients[1], ingredients[3], ingredients[7], ingredients[10], ingredients[11], ingredients[12]]
  ]
# recipes.length.times do |recipe|
# [ingredients[3], ingredients[4], ingredients[5]].each do |ing|
#   IngredientRecipe.create(
#     recipe_id: Recipe.find_by(title: recipe.title).id,
#     ingredient_id: ing.id,
#     quantity: "1.5 cups"
#   )
# end

#traverse through each element index
ingredients_for_recipes_list.each_index do |i|
  #quesadilla
  recipe = recipes[i]
  #quesadilla ingredients
  ingredients_for_recipe = ingredients_for_recipes_list[i]

  #for each ingredient for quesadilla
  ingredients_for_recipe.each do |ing|
    #create an IngredientRecipe
    IngredientRecipe.create(
      #recipe_id will be found by pinging database via quesdilla's title
      recipe_id: Recipe.find_by(title: recipe.title).id,
      ingredient_id: Ingredient.find_by(name: ing.name).id,
      quantity: "35 slices"
    )
  end
end



# mac = recipes[1].ingredients.push(ingredients[3], ingredients[6])
# omelette = recipes[2].ingredients.push(ingredients[2], ingredients[3], ingredients[7], ingredients[8], ingredients[9], ingredients[12])
# spaghetti = recipes[3].ingredients.push(ingredients[3], ingredients[6], ingredients[7], ingredients[10])
# hamburger = recipes[4].ingredients.push(ingredients[1], ingredients[3], ingredients[7], ingredients[10], ingredients[11], ingredients[12])
# blt = recipes[5].ingredients.push(ingredients[1], ingredients[7], ingredients[11], ingredients[12])
# burrito = recipes[6].ingredients.push(ingredients[0], ingredients[3], ingredients[4], ingredients[5], ingredients[11])
# chickenSoup = recipes[7].ingredients.push(ingredients[5], ingredients[6])
# taco = recipes[8].ingredients.push(ingredients[0], ingredients[3], ingredients[4], ingredients[5], ingredients[11], ingredients[12])
# stirFry = recipes[9].ingredients.push(ingredients[5], ingredients[9], ingredients[12])
