class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    session[:user] = { name: user_params[:name], room: params[:poker_room_id].to_i }

    redirect_to poker_room_path(params[:poker_room_id].to_i)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
