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

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(set_params)
			flash[:success] = "Recipe was updated successfully"
			redirect_to recipe_path(@recipe)
		else
			render 'edit'
		end
	end


	def destroy
		Recipe.find(params[:id]).destroy
		flash[:success] ="Recipe deleted successfully"
		redirect_to recipes_path
	end



	private

	def set_params
		params.require(:recipe).permit(:name,:description)
	end

end