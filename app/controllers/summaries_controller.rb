class SummariesController < ApplicationController
  def index
    summaries = PokerRoom.find(params[:poker_room_id]).summaries.order(created_at: :desc).limit(100).reverse
    render json: summaries, status: :ok
  end

  def create
    summary = Summary.create(summary_params.merge(votes: params[:summary][:votes]))
    render json: summary, status: :ok
  end

  private

  def summary_params
    params.require(:summary).permit(:story, :votes, :poker_room_id)
  end
end
