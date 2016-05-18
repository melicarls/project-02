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

end
