require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'User Mailer' do
    before :each do
      @email = "piotrek@test.com"
      @poker_room = FactoryGirl.create(:poker_room)
      FactoryGirl.create(:summary)
      @summaries = PokerRoom.find(@poker_room.id).summaries.order(created_at: :desc).limit(100).reverse
    end

    let(:newsletter_notification) { UserMailer.summaries_list_notification(@email, @poker_room.id, @summaries) }

    it "sends summaries list notification email" do
      expect do
        newsletter_notification.deliver_now
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
