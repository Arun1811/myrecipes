require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = User.create!(username: "Arun1", email: "arun@example.com", 
						password: "password", password_confirmation: "password")
		@users = User.create!(username: "Arun6", email: "arun5@example.com", 
						password: "password", password_confirmation: "password")

		@admin_user = User.create!(username: "Arun2", email: "arun2@example.com", 
						password: "password", password_confirmation: "password", admin: true)
	end

 	test "reject an invalid edit" do
 		sign_in_as(@user, "password")
 		get edit_user_path(@user)
 		assert_template 'users/edit'
 		patch user_path(@user), params:{user: { username: " ", email: "arun@example.com"}}
 		assert_template 'users/edit'
 		assert_select 'h2.panel-title'
 		assert_select 'div.panel-body'
 	end

 	test "accept valid edit" do
 		sign_in_as(@user, "password")
		get edit_user_path(@user)
 		assert_template 'users/edit'
 		patch user_path(@user), params:{user: { username: "arun", email: "arun@example.com"}}
 		assert_redirected_to @user
 		assert_not flash.empty?
 		@user.reload
 		assert_match "arun", @user.username
 		assert_match "arun@example.com",@user.email
 	end

 	test "accept edit attempt by admin user" do
		sign_in_as(@admin_user, "password")
		get edit_user_path(@user)
 		assert_template 'users/edit'
 		patch user_path(@user), params:{user: { username: "Arun3", email: "arun3@example.com"}}
 		assert_redirected_to @user
 		assert_not flash.empty?
 		@user.reload
 		assert_match "Arun3", @user.username
 		assert_match "arun3@example.com",@user.email
 	end

 	test "redirect edit attempt by another non-admin user" do
		sign_in_as(@users, "password")
		updated_name = "joh"
		updated_email = "joh@example.com"
 		patch user_path(@user), params:{user: { username: updated_name, email: updated_email}}
 		assert_redirected_to users_path
 		assert_not flash.empty?
 		@user.reload
		assert_match "Arun1", @user.username
 		assert_match "arun@example.com",@user.email
 	end
end
