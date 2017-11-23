require 'test_helper'

class UsersListingTest < ActionDispatch::IntegrationTest
	def setup
		@user = User.create!(username: "Arun 1", email: "arun@example.com", 
						password: "password", password_confirmation: "password")
		@users = User.create!(username: "Arun 2", email: "arun2@example.com", 
						password: "password", password_confirmation: "password")
		@admin_user = User.create!(username: "Arun 3", email: "arun3@example.com", 
						password: "password", password_confirmation: "password", admin: true)
	end

	test "should get users listing" do 
		get users_path
		assert_template 'users/index'
		# assert_match @recipe.name, response.body
		assert_select "a[href=?]",user_path(@user), text: @user.username.capitalize
		# assert_match @users.name, response.body
		assert_select "a[href=?]",user_path(@users), text: @users.username.capitalize
	end

	test "should delete user" do
		sign_in_as(@admin_user, "password")
		get users_path
		assert_template 'users/index'
		assert_difference 'User.count', -1 do
			delete user_path(@user)
		end
		assert_redirected_to  users_path
		assert_not flash.empty?
	end
end
