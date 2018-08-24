class FriendshipsController < ApplicationController
	
	def destroy
		@friendship = current_user.friendships.where(friend_id: params[:id]).first
		if @friendship.destroy
			flash[:notice] = "Friend was successfully removed !"
		else
			flash[:danger] = "There was an error with that request !"
		end
		redirect_to friends_path
	end
	
end