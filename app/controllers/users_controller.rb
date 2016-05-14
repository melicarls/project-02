class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @recipe = Recipe.all
  end
  private
  def recipe_params
    params.require(:recipe).permit(:title, :author, :image, :directions)
  end
end
