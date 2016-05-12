Rails.application.routes.draw do
# Root route
  root to: 'recipes#search'



#Recipe Routes
  get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
  post '/recipes', to: 'recipes#create'
  get 'recipes/:id', to: 'recipes#show', as: 'recipe'
  get '/recipes/:id/edit', to: 'recipes#edit', as: 'edit_recipe'
  patch 'recipes/:id', to: 'recipes#update'













# Catch-all route
  match '*path', to: 'recipes#search', via: :all



end
