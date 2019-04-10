require 'rails_helper'

RSpec.describe "Merchant adding an item" do
  before :each do
    @merchant = create(:merchant)
    login_as(@merchant)
    visit dashboard_items_path
    click_link "Add new Item"
  end

  describe "happy path" do
    before :each do
      fill_in :item_name, with: "item name 1"
      fill_in :item_price, with: "2.99"
      fill_in :item_description, with: "item description 1"
      fill_in :item_inventory, with: "0"
    end

    it "creates an item" do
      expect(current_path).to eq(new_dashboard_item_path)

      fill_in :item_image, with: "https://picsum.photos/200/300"

      click_button "Create Item"

      new_item = Item.last
      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Your Item has been saved!")

      within "#item-#{new_item.id}" do
        expect(page).to have_content(new_item.name)
        expect(page).to have_content(new_item.price)
        expect(page).to have_content(new_item.inventory)
        expect(page).to have_xpath("//img[@src='#{new_item.image}']")
        expect(page).to have_button("Disable Item")
      end
    end

    it "can leave image blank" do
      click_button "Create Item"

      new_item = Item.last
      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content("Your Item has been saved!")

      within "#item-#{new_item.id}" do
        expect(page).to have_content(new_item.name)
        expect(page).to have_content(new_item.price)
        expect(page).to have_content(new_item.inventory)
        expect(page).to have_xpath("//img[@src='https://picsum.photos/200/300']")
        expect(page).to have_button("Disable Item")
      end
    end
  end

  describe "sad path" do
    it "cannot leave fields blank" do
      click_button "Create Item"

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Price can't be blank")
      expect(page).to have_content("Inventory can't be blank")
    end

    it "cannot enter price less than or equal to 0" do
      fill_in :item_price, with: "0"
      click_button "Create Item"

      expect(page).to have_content("Price must be greater than 0")
    end

    it "cannot enter inventory less than 0" do
      fill_in :item_inventory, with: "-1"
      click_button "Create Item"

      expect(page).to have_content("Inventory must be greater than or equal to 0")
    end
  end
end
