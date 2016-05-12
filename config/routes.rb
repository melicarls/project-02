Rails.application.routes.draw do

  #Recipe Routes
    get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
    post '/recipes', to: 'recipes#create'

end
