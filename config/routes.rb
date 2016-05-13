Rails.application.routes.draw do
# Root route
  root to: 'recipes#search'



#Recipe Routes
  get '/recipes/index', to: 'recipes#index', as: 'recipes'
  get '/recipes/search', to: 'recipes#search', as: 'search_recipes'
  get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
  post '/recipes', to: 'recipes#create'
  get 'recipes/:id', to: 'recipes#show', as: 'recipe'
  get '/recipes/:id/edit', to: 'recipes#edit', as: 'edit_recipe'
  patch '/recipes/:id', to: 'recipes#update'
  delete '/recipes/:id', to: 'recipes#destroy', as: 'destroy_recipe'


  get '/users/:id', to: 'users#show', as: 'user'



  devise_for :users







# Catch-all route
  match '*path', to: 'recipes#search', via: :all



end
