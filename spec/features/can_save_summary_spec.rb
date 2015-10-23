feature "can save summary", type: :feature, js: true, focus: true do
  scenario "can see summary record" do
    visit root_path

    within '#poker-room-form' do
      fill_in 'poker_room_user_story', with: 'Login funcionality'
      click_on 'Create Room'
    end

    within '#name-form' do
      fill_in 'name-field', with: 'Zbyszek'
      click_on 'Create'
    end

    click_on '1'
    click_on 'Clear all votes'

    expect(page).to have_content 'Login funcionality :'
  end
end
