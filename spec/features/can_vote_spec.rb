feature "visit home page feature", type: :feature, js: true do
  scenario "shows me home page" do
    visit root_path

    within '#poker-room-form' do
      fill_in 'poker_room_user_story', with: 'Login functionality'
      click_on 'Create Room'
    end

    within '#name-form' do
      fill_in 'name-field', with: 'Zbyszek'
      click_on 'Create'
    end

    within '#user-story-form' do
      click_on '1'
    end

    expect(page).to have_content 'Zbyszek : 1'
  end
end
