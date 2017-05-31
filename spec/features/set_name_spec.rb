feature "can set name", type: :feature, js: true do
  scenario "changes my name" do
    visit root_path

    within '#poker-room-form' do
      click_on 'Create Room'
    end

    within '#name-form' do
      fill_in 'name-field', with: 'Zbyszek'
      click_on 'Create'
    end

    expect(page).to have_content 'Poker Room'
  end
end
