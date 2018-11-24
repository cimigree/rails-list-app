require "rails_helper"

RSpec.feature "Creating Items" do
  scenario "A user creates a new item" do
    visit "/"

    click_link "Add New Item"

    fill_in "Name", with: "Mom bread"
    fill_in "Brand name", with: "Pepperidge Farm"
    select "Biweekly", from: "Frequency"

    click_button "Create Item"
    expect(page).to have_content("Item has been added")
    expect(page.current_path).to eq(items_path)
  end
end