class SummariesListNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(room, email)
    summaries = PokerRoom.find(room).summaries.order(created_at: :desc).limit(100).reverse
    UserMailer.summaries_list_notification(email, room, summaries).deliver_now if summaries.any?
  end
end
