feature "visit home page feature", type: :feature, js: true do
  scenario "shows me home page" do
    visit root_path

    expect(page).to have_content 'CREATE ROOM'
  end
end
