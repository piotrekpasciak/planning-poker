# == Schema Information
#
# Table name: poker_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_story :string
#  votes      :text
#

FactoryGirl.define do
  factory :poker_room do
    user_story "User can Login to application"
    votes ["0", "0.5", "1", "2", "3", "5", "8", "13", "20", "40", "100", "200"]
  end
end
