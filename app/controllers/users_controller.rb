class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def star
    @recipe = Recipe.find(params[:id])
    if !current_user
      flash[:error] = "Oh no! You're not logged in, so you can't save favorites."
      redirect_to recipe_path(@recipe)
    end
    @user = current_user
    if !@user.recipes.include?(@recipe)
      @user.recipes << @recipe
      flash[:success] = "This recipe has been added to your favorites."
    else
      flash[:error] = "This recipe is already in your favorites."
    end
    redirect_to recipe_path(@recipe)
  end

  def removestar
  end

end
