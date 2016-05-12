Rails.application.routes.draw do
# Root route
  root to: 'recipes#search'



#Recipe Routes
  get '/recipes', to: 'recipes#search', as: 'search_recipes'
  get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
  post '/recipes', to: 'recipes#create'















# Catch-all route
  match '*path', to: 'recipes#search', via: :all



end
