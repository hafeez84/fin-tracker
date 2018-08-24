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

	def add_friend
		@f = User.find(params[:friend])
		current_user.friendships.build(friend_id: @f.id)
		if current_user.save
			flash[:notice] = "Friend have successfully added !"
		else
			flash[:danger] = "There was something wrong with the friend request !"
		end
		redirect_to friends_path
	end

	def show
		@user = User.find(params[:id])
		@user_stocks = @user.stocks
	end
end