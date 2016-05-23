class UsersController < ApplicationController

  # TODO: Be careful, your user routes are visible to ALL people, logged in or not.  Consider adding a current_user.id == params[:id] check to ensure privacy -jc
  def show
    @user = User.find(params[:id])
  end

  # TODO: Please include a brief comment on this awesome method -jc
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
      flash[:warning] = "This recipe is already in your favorites."
    end
    redirect_to recipe_path(@recipe)
  end

  # TODO: Please include a brief comment on this awesome method -jc
  def removestar
    @recipe = Recipe.find(params[:id])
    if !current_user
      flash[:error] = "Oh no! You're not logged in, so we can't remove anything from your favorites list."
      redirect_to recipe_path(@recipe)
    end
    @user = current_user
    if @user.recipes.include?(@recipe)
      @user.recipes.delete(@recipe)
      flash[:success] = "This recipe has been removed from your favorites"
    else
      flash[:warning] = "That recipe isn't in your favorites."
    end
    redirect_to recipe_path(@recipe)
  end

end
