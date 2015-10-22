# == Schema Information
#
# Table name: poker_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_story :string
#

FactoryGirl.define do
  factory :poker_room do
  end
end
