Rails.application.routes.draw do











  get '/recipes', to: 'recipes#search', as: 'search_recipes'


end
