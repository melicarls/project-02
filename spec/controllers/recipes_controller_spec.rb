require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  # let(:signed_in_user) { User.create ({email:'test@test.com'})}
  # before do
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(signed_in_user)
  # end
  describe "#show" do
    let(:recipe) {Recipe.create({title:'fried rice', author:'john smith', directions:'1. chop veggies 2. make rice'}) }

    before(:each) do
      get :show, id: recipe.id
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end

    it "assigns @recipe" do
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe "#search" do
    let!(:all_ingredients) {Ingredient.all}
    before { get :search}

    it "assigns @ingredients" do
      expect(assigns(:ingredients)).to eq(all_ingredients)
    end

    it "renders the :search view" do
      expect(response).to render_template(:search)
    end
  end

  describe "#index" do
    subject { get :index, :key_arr => [] }
    before { get :index }

    it "returns a flash error message if no ingredients chosen" do
      expect(flash[:error]).to eq("Sorry, you can't make something out of nothing. Go grocery shopping and try again.")
    end

    it "redirects back to search if no ingredients chosen" do
      expect(response).to redirect_to(search_recipes_path)
    end

  #   #Don't run this until get_recipes takes only one array of ingredients, the ones user has chosen.
  #   it "returns recipe(s) when given an ingredient" do
  #     #we are calling get_recipes instead of :recipe because it expects an array of ingredients.
  #     expect(get_recipes(Ingredient.all).length).to eq(1)
  #   end
  end

end
