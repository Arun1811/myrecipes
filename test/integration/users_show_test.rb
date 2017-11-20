require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
	def setup
		@user = User.create!(username: "Arun 1", email: "arun@example.com", 
						password: "password", password_confirmation: "password")
		@recipe = Recipe.create(name: "Vegetable saute", description: "greatest Vegetable, add Vegetableand oil", user: @user)
		@recipes = @user.recipes.build(name: "Vegetable saute", description: "greatest Vegetable, add Vegetableand oil")
		@recipes.save
	end

	test "should get users show" do 
		get user_path(@user)
		assert_template 'users/show'
		assert_select "a[href=?]",recipe_path(@recipe), text: @recipe.name
		assert_select "a[href=?]",recipe_path(@recipes), text: @recipe.name
		assert_match @recipe.description, response.body
		assert_match @recipes.description, response.body
		assert_match @user.username, response.body

	end
end
