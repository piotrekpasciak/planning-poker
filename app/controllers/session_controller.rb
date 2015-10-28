class SessionController < ApplicationController
  respond_to :html

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    unless @user.valid?
      return respond_with @user
    end

    session[:user] = { name: user_params[:name], room: params[:poker_room_id].to_i }

    redirect_to poker_room_path(params[:poker_room_id].to_i)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
