feature "can see nicknames", type: :feature, js: true do
  scenario "can see nicknames" do
    visit root_path

    within '#poker-room-form' do
      fill_in 'poker_room_user_story', with: 'Login functionality'
      click_on 'Create Room'
    end

    within '#name-form' do
      fill_in 'name-field', with: 'Zbyszek'
      click_on 'Create'
    end

    expect(page).to have_content 'Zbyszek'
  end
end
