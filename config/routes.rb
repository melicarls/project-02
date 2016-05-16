Rails.application.routes.draw do
# Root route
  root to: 'recipes#search'



#Recipe Routes
  # get '/recipes/index', to: 'recipes#index', as: 'recipes'
  # post '/recipes', to: 'recipes#create'
  # get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
  # get '/recipes/:id/edit', to: 'recipes#edit', as: 'edit_recipe'
  # get 'recipes/:id', to: 'recipes#show', as: 'recipe'
  # patch '/recipes/:id', to: 'recipes#update'
  # put '/recipes/:id', to: 'recipes#update'
  # delete '/recipes/:id', to: 'recipes#destroy'

  get '/search', to: 'recipes#search', as: 'search_recipes'

  resources :recipes

  devise_for :users, :controllers => {:registrations => "my_devise/registrations"}

  get '/users/:id', to: 'users#show', as: 'user'


  get '/about', to: 'recipes#about', as: 'about'










# Catch-all route
  match '*path', to: 'recipes#search', via: :all



end
