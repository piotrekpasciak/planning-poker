feature "visit home page feature", type: :feature, js: true do
  scenario "shows me home page" do
    visit root_path

    within '#create' do
      click_on 'create-room'
    end
    expect(page).to have_content 'Poker Room'
  end
end
