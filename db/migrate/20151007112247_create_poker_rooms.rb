class CreatePokerRooms < ActiveRecord::Migration
  def change
    create_table :poker_rooms do |t|

      t.timestamps null: false
    end
  end
end
