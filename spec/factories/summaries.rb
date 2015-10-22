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

FactoryGirl.define do
  factory :summary do
    story "MyString"
    votes "MyText"
    poker_room nil
  end
end
