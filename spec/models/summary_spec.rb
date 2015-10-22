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

require 'rails_helper'

RSpec.describe Summary, type: :model do
end
