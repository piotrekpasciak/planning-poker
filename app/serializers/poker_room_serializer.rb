class PokerRoomSerializer < ActiveModel::Serializer
  attributes :id, :user_story, :user_name

  def user_name
    current_user["name"]
  end
end
