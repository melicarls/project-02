Rails.application.routes.draw do
# Root route
  root to: 'recipes#search'
#Recipe Routes
  get '/search', to: 'recipes#search', as: 'search_recipes'
  resources :recipes, only: [:index, :show]
  devise_for :users, :controllers => {:registrations => "my_devise/registrations"}
  get '/users/:id', to: 'users#show', as: 'user'
  post '/users/starred/:id', to: 'users#star', as: 'new_user_star'
  delete '/users/starred/:id', to: 'users#removestar', as: 'delete_user_star'
  get '/about', to: 'recipes#about', as: 'about'
# Catch-all route
  match '*path', to: 'recipes#search', via: :all
end
