class UserMailer < ApplicationMailer
  default from: "moka_pot_club@pgs-soft.com"

  def summaries_list_notification(email, poker_room_number, summaries)
    @summaries = summaries
    mail(to: email,
         subject: "Summaries list of Poker room number " + poker_room_number.to_s)
  end
end
