class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    session[:user_name] = user_params[:name]

    return redirect_to root_path if session[:last_room].nil?

    redirect_to poker_room_path(session[:last_room])
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
