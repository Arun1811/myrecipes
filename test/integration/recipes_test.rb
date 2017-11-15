
require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create!(username: "Arun 1", email: "arun@example.com")
		@recipe = Recipe.create(name: "Vegetable saute", description: "greatest Vegetable, add Vegetableand oil", user: @user)
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
		# assert_match @recipe.name, response.body
		assert_select "a[href=?]",recipe_path(@recipe), text: @recipe.name
		# assert_match @recipes.name, response.body
		assert_select "a[href=?]",recipe_path(@recipes), text: @recipe.name
	end

	test "should get recipes show" do
		get recipe_path(@recipe)
		assert_template 'recipes/show'
		assert_match @recipe.name, response.body
		assert_match @recipe.description, response.body
		assert_match @user.username, response.body
	end

	test "create new valid recipe" do
		get new_recipe_path
		assert_template 'recipes/new'
		name_of_recipe = "Chicken saute"
		description_of_recipe = "add chicken, add Vegetables, cook for 20 minutes, serve delicious meal"
		assert_difference 'Recipe.count',1 do
			post recipes_path, params:{recipe:{name: name_of_recipe, description: description_of_recipe}}
		end
		follow_redirect!
		assert_match name_of_recipe.capitalize, response.body
		assert_match description_of_recipe, response.body
	end

	test "reject invalid recipe submissions" do
		get new_recipe_path
		assert_template 'recipes/new'
		assert_no_difference  'Recipe.count' do
			post recipes_path, params: {recipe: {name: " ", description: " "}}
		end
		assert_template 'recipes/new'
		assert_select 'h2.panel-title'
		assert_select 'div.panel-body'
	end
end
