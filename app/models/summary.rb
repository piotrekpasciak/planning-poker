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

class Summary < ActiveRecord::Base
  belongs_to :poker_room

  serialize :votes, Array

  validates :story, :votes, :poker_room_id, presence: true

end
