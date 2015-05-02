class SessionsController < ApplicationController
    def new
    end

    def create
        user_params = params.require(:user)
        user = User.confirm(user_params[:email], user_params[:password])

        if user

            # login is a session helper method
            login(user)
            # which creates a cookie with the user.id in it, like this:
            # session[:user_id] = user.id

            redirect_to user_path(user.id)
        else
            # Flash an error message; to appear, it must be rendered on
            # the view with the sign-in form
            flash[:error] = "Failed To Authenticate. Please try again."

            redirect_to "/login"
        end
    end
end
