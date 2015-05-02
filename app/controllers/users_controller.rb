class UsersController < ApplicationController
	# logged_in? is a session helper method that basically
	# checks that current_user is not nil; if it is, then
	# the controller redicts to /login
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

# Why Make the Helper Methods Private?

# So, why is it important to make methods like this private? 
# Because you don’t want them to be accessible to your users. 
# They can’t hit that method unless you have defined a route 
# that points to it as an action. While unlikely, it’s possible 
# that you might have such a route defined. Or, if you have 
# some type of catch-all route defined, then this 
# check_something method could actually be accessed by a user.

# In most cases, this will be unlikely to happen. And if it 
# does happen, it’s likely that little harm could be done. 
# However, making these non-action methods privates also makes 
# your code a bit more clear by declaring that these methods 
# are NOT accessible via any routes. So, simply put, you 
# should make the non-action methods private because it’s a 
# best practice.

	private

		def user_params
	    	params.require(:user).permit(:email, :password, :password_confirmation)
		end

end
