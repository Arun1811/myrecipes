require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest


	def setup
		@user = User.create!(username: "Arun 1", email: "arun@example.com")
		@recipe = Recipe.create(name: "Vegetable saute", description: "greatest Vegetable, add Vegetableand oil", user_id: @user)
		@recipes = @user.recipes.build(name: "Vegetable saute", description: "greatest Vegetable, add Vegetableand oil")
		@recipes.save
	end

	test "should get recipes index" do
		get recipes_path
		assert_response :success
	end

	test "should get recipes listing" do
		get recipes_path
		assert_template 'recipes/index'
		assert_match @recipe.name, response.body
		assert_match @recipes.name, response.body
	end
end
