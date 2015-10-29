class HardWorker
  include Sidekiq::Worker

  def perform(room, email)
    summaries = PokerRoom.find(room).summaries.order(created_at: :desc).limit(100).reverse
    UserMailer.summaries_list_notification(email, room, summaries).deliver_later
  end
end
