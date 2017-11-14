require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(username: "Arun", email: "arunpuduvai@gmail.com")
	end

	test "user should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.username = " "
		assert_not @user.valid?
	end

	test "name should be less than 30 characters" do
		@user.username = "a" * 31
		assert_not @user.valid?
	end


	test "email should be present" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "a" * 245 + "@example.com"
		assert_not @user.valid?
	end

	test "email should be correct format" do
		valid_email = %w[user@exampl.com arunpuduvai@gmail.com M.frist@yahoo.ca john+smith@co.uk.org]
		valid_email.each do |valids|
		@user.email = valids
		assert @user.valid?, "#{valids.inspect} shoud be valid"
	end
	end

	test "should reject invalid addresses" do
		invalid_email = %w[user@example arunpuduvai,com M.first.ca john+smith@co,]
		invalid_email.each do |invalids|
			@user.email = invalids
			assert_not @user.valid?, "#{invalids.inspect} should be invalid"
		end
	end


	test "email should be unique and case insensitive" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email should be lowercase before hitting db" do
		mixed_email = "JohN@Example.com"
		@user.email = mixed_email
		@user.save
		assert_equal mixed_email.downcase, @user.reload.email

	end



end