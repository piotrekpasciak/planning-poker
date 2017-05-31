class AddVotesToPokerRooms < ActiveRecord::Migration
  def change
    add_column :poker_rooms, :votes, :text
  end
end
