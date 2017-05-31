class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.string :story
      t.text :votes
      t.references :poker_room, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
