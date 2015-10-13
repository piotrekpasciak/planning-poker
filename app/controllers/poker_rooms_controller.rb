class PokerRoomsController < ApplicationController
  before_action :set_poker_room, only: [:show]

  def new
    @poker_room = PokerRoom.new
  end

  def show
    session[:last_room] = @poker_room.id
    return redirect_to new_session_path if current_user.nil?

    respond_to do |format|
      format.html
      format.json { render json: @poker_room }
    end
  end

  def create
    poker_room = PokerRoom.create
    redirect_to poker_room_path(poker_room)
  end

  private

  def set_poker_room
    @poker_room = PokerRoom.find(params[:id])
  end
end
