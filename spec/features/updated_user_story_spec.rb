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
      fill_in 'user-story', with: 'Register functionality'
      click_on 'Send'
    end

    visit poker_room_path(1)

    expect(find_field('user-story').value).to eq 'Register functionality'
  end
end
