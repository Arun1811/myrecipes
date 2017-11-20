require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

	def setup
		@user = User.create!(username: "Arun", email: "arunpuduvai@gmail.com", password: "password", password_confirmation: "password")
		@recipe = @user.recipes.build(name: "Vegetable", description: "greate Vegetable recipe")
	end

	test "recipe without user should be invalid" do
		@recipe.user_id = nil
		assert_not @recipe.valid?
	end

	test "recipe should be valid" do
		assert @recipe.valid?
	end

	test "name should be present" do
		@recipe.name = " "
		assert_not @recipe.valid?
	end

	test "description should be present" do
		@recipe.description = " "
		assert_not @recipe.valid?
	end

	test "description shouldn't be less than 5 characters" do
		@recipe.description = "a" * 3
		assert_not @recipe.valid?
	end

	test "description shouldn't be more than 500 characters" do
		@recipe.description = "a" * 501
		assert_not @recipe.valid?
	end

end