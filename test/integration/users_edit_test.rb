require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = User.create!(username: "Arun 1", email: "arun@example.com", 
						password: "password", password_confirmation: "password")
		@recipe = Recipe.create(name: "Vegetable saute", description: "greatest Vegetable, add Vegetableand oil", user: @user)
	end

 	test "reject an invalid edit" do
 		get edit_user_path(@user)
 		assert_template 'users/edit'
 		patch user_path(@user), params:{user: { username: " ", email: "arun@example.com"}}
 		assert_template 'users/edit'
 		assert_select 'h2.panel-title'
 		assert_select 'div.panel-body'
 	end

 	test "accept valid signup" do
		get edit_user_path(@user)
 		assert_template 'users/edit'
 		patch user_path(@user), params:{user: { username: "arun", email: "arun@example.com"}}
 		assert_redirected_to @user
 		assert_not flash.empty?
 		@user.reload
 		assert_match "arun", @user.username
 		assert_match "arun@example.com",@user.email
 	end
end
