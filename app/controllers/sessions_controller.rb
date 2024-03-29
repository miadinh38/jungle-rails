class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to '/'
      puts "Login sucessful!"
    else
      flash[:error] = "Your email or password is incorrect!"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil 
    redirect_to '/'
  end

end