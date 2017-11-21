class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Welcome #{@user.username} to MyRecipes App!"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@user_recipes = @user.recipes.paginate(page: params[:page], per_page: 5)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:success]= "Your account was updated successfully"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = "User and all associated recipes have been deleted"
		redirect_to users_path
	end

	private

	def user_params
		params.require(:user).permit(:username, :email,:password, :password_confirmation)
	end

end