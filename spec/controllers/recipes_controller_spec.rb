require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
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

  describe "#new" do
    before { get :new }

    it "assigns @recipe" do
      expect(assigns(:recipe)).to be_instance_of(Recipe)
    end
    it "renders the :new view" do
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "success" do
      let(:recipe_hash) {{title: "wonton soup", author: "jack sparrow", directions:"1. boil water 2. chop veggies"}}
      let!(:recipes_count) {Recipe.count}
      before(:each) do
        post :create, recipe: recipe_hash
      end

      it "redirects to 'recipe_path'" do
        expect(response.status).to be(302)
        expect(response.location).to match(/\/recipes\/\d+/)
      end

      it "adds a recipe to the database" do
        expect(Recipe.count).to eq(recipes_count + 1)
      end
    end

    context "failed validations" do
      let(:recipe_hash) {{ title: "sushi", author: "jerry springer", description: nil}}
      before do
        post :create, recipe: recipe_hash
      end
      it "redirects to 'new_recipe_path'" do
        expect(response.status).to be(302)
        expect(response).to redirect_to(new_recipe_path)
      end
      it "adds a flash error message" do
        expect(flash[:error]).to be_present
      end
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
