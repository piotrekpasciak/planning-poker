# == Schema Information
#
# Table name: summaries
#
#  id            :integer          not null, primary key
#  story         :string
#  votes         :text
#  poker_room_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :summary do
    story "User can Login to application"
    votes [{ name: "Pszemek", vote: "" }, { name: "Kamil", vote: "8" }, { name: "Zbyszek", vote: "3" }]
    poker_room
  end
end
