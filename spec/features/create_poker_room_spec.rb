feature "can create poker room", type: :feature, js: true do
  scenario "shows me poker room" do
    visit root_path

    within '#poker-room-form' do
      fill_in 'poker_room_user_story', with: 'Login functionality'
      click_on 'Create Room'
    end

    within '#name-form' do
      fill_in 'name-field', with: 'Zbyszek'
      click_on 'Create'
    end

    expect(page).to have_content 'Poker Room'
  end
end
