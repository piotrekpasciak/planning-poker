class SummariesController < ApplicationController
  def index
    summaries = PokerRoom.find(params[:poker_room_id]).summaries.order(created_at: :desc).limit(100).reverse
    render json: summaries, status: :ok
  end

  def create
    summary = Summary.create(summary_params.merge(votes: params[:summary][:votes]))
    render json: summary, status: :ok
  end

  def send_email
    SummariesListNotificationJob.perform_later(params[:poker_room_id], email_params)
    render json: email_params.to_json, status: :ok
  end

  private

  def summary_params
    params.require(:summary).permit(:story, :votes, :poker_room_id, :created_at)
  end

  def email_params
    params.require(:email)
  end
end
