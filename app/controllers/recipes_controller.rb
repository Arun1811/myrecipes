class RecipesController < ApplicationController

	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(set_params)
		@recipe.user = User.first
		if @recipe.save
			flash[:success] = "Recipe was created successfully"
			redirect_to recipe_path(@recipe)
		else
			render 'new'
		end
	end



	private

	def set_params
		params.require(:recipe).permit(:name,:description)
	end

end