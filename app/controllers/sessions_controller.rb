class SessionsController < ApplicationController

  def new
  end

  def login
    user = User.where("email = '#{params[:email]}'").first
    if user && user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to posts_url, notice: "Logged in as #{user.email}."
    else
      flash[:error] = "Invalid credentials. Try again."
      render :new
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to posts_url, notice: "Logged out"
  end
end
