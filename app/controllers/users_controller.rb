class UsersController < ApplicationController
	before_action :logged_in?, only: [:show]

	def new
		@user = User.new
	end

	def create
		if @password == @password_confirmation
	    	@user = User.create(user_params)
			redirect_to user_path(@user.id)
		else
			# did not match ...
		end
	end

	def show
	end

	private

		def user_params
	    	params.require(:user).permit(:email, :password, :password_confirmation)
		end

end
