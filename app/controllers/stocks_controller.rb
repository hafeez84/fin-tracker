class StocksController < ApplicationController
	def search
		if params[:stock].present?
			@st = Stock.new_from_lookup(params[:stock])
			if @st
				render 'users/my_portfolio'
			else
				flash[:danger] = "You have entred and inccorect symbol !"
				redirect_to my_portfolio_path
			end
		else
			flash[:danger] = "You have entered an empty string !"
			redirect_to my_portfolio_path
		end
	end
	
end