class AddUserStoryToPokerRooms < ActiveRecord::Migration
  def change
    add_column :poker_rooms, :user_story, :string
  end
end
