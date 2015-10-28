class SessionController < ApplicationController
  respond_to :html

  def new
    @user = User.new
  end

  def create
    if user_params[:name].empty?
      @user = User.new
      @user.errors.add(:name, "cannot be empty!")
      return respond_with @user
    elsif user_params[:name].length > 100
      @user = User.new
      @user.errors.add(:name, "cannot be longer then 100 characters!")
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
