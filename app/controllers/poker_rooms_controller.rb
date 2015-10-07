class PokerRoomsController < ApplicationController
  before_action :set_poker_room, only: [:show]

  def new
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @poker_room }
    end
  end

  def create
    poker_room = PokerRoom.create
    render json: poker_room, status: :ok
  end

  private

  def set_poker_room
    @poker_room = PokerRoom.find(params[:id])
  end
end
