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

class PokerRoomSerializer < ActiveModel::Serializer
  attributes :id, :user_story, :user_name, :votes

  def user_name
    current_user["name"]
  end
end
