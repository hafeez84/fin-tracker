class UsersController < ApplicationController
	def my_portfolio
		@user = current_user
		@user_stocks = current_user.stocks
	end

	def my_friends
		@frnds = current_user.friends
	end

	def search
		if params[:friend].blank?
			flash.now[:danger] = "You have entered and empty string !"
		else
			@users =  User.search(params[:friend])
			@users = current_user.except_current_user(@users)
			flash.now[:danger] = "No users match this search criteria !" if @users.blank?
		end
		# render json: @users
		render partial: 'friends/result'
	end
end