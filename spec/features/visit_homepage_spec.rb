feature "visit home page feature", type: :feature do
  scenario "shows me home page" do
    visit root_path

    expect(page).to have_content 'Poker room'
  end
end
