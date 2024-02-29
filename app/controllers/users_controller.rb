class UsersController < ApplicationController

  # render the signup form
  def new
  end
  
  # recieve the form and create a user with the form's parameters
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
      puts "Created!"
    else
      redirect_to '/signup'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end