Rails.application.routes.draw do

  root to: 'recipes#search'









  get '/recipes', to: 'recipes#search', as: 'search_recipes'


end
