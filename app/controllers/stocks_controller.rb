class StocksController < ApplicationController
	def search
		if params[:stock].blank?
			flash.now[:danger] = "You have entered an empty string !"	
		else
			@st = Stock.new_from_lookup(params[:stock])
			flash.now[:danger] = "You have entred and inccorect symbol !" unless @st
		end
		render partial: 'users/results'	
	end
end