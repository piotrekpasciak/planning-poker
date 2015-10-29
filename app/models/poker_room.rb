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

class PokerRoom < ActiveRecord::Base
  has_many :summaries

  serialize :votes, Array
end
