require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = User.create!(username: "Arun 1", email: "arun@example.com", 
						password: "password", password_confirmation: "password")
		@recipe = Recipe.create(name: "Vegetable saute", description: "greatest Vegetable, add Vegetableand oil", user: @user)
	end

	test "reject invalid recipe update" do 
		sign_in_as(@user, "password")
		get edit_recipe_path(@recipe)
		assert_template 'recipes/edit'
		patch recipe_path(@recipe), params: {recipe: {name: " ", description: "some description"}}
		assert_template 'recipes/edit'
		assert_select 'h2.panel-title'
		assert_select 'div.panel-body'

	end

	test "successfully edit recipe" do
		sign_in_as(@user, "password")
		get edit_recipe_path(@recipe)
		assert_template 'recipes/edit'
		update_name = "updated recipe name"
		updated_description = "udpated description name"
		patch recipe_path(@recipe), params: {recipe:{name: update_name, description: updated_description}}
		assert_redirected_to @recipe
		# follow_redirect!
		assert_not flash.empty?
		@recipe.reload
		assert_match update_name, @recipe.name
		assert_match updated_description, @recipe.description
	end

end
