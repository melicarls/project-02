Rails.application.routes.draw do
# Root route
  root to: 'recipes#search'









  get '/recipes', to: 'recipes#search', as: 'search_recipes'









# Catch-all route
  match '*path', to: 'recipes#search', via: :all

end
