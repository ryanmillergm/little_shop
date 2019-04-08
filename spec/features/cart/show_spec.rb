require 'rails_helper'

RSpec.describe "Cart show page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, user: @merchant_1)
    @item_2 = create(:item, user: @merchant_2)
    @item_3 = create(:item, user: @merchant_2)
  end

  context "a regular user or visitor sees their cart summary" do
    scenario "as a regular user" do
      user = create(:user)
      login_as(user)
    end

    scenario "as a visitor" do
    end

    after :each do
      visit item_path(@item_1)
      click_on "Add to Cart"
      visit item_path(@item_2)
      click_on "Add to Cart"
      visit item_path(@item_3)
      click_on "Add to Cart"
      visit item_path(@item_3)
      click_on "Add to Cart"

      visit cart_path
      
      expect(page).to have_content("Total: $#{@item_1.price + @item_2.price + @item_3.price * 2}")

      expect(page).to have_link("Empty Cart")

      within("#item-#{@item_1.id}") do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_xpath("//img[@src='#{@item_1.image}']")
        expect(page).to have_content(@item_1.user.name)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content("quantity: 1")
        expect(page).to have_content("subtotal: $#{@item_1.price}")
      end

      within("#item-#{@item_2.id}") do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_xpath("//img[@src='#{@item_2.image}']")
        expect(page).to have_content(@item_2.user.name)
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content("quantity: 1")
        expect(page).to have_content("subtotal: $#{@item_2.price}")
      end

      within("#item-#{@item_3.id}") do
        expect(page).to have_content(@item_3.name)
        expect(page).to have_xpath("//img[@src='#{@item_3.image}']")
        expect(page).to have_content(@item_3.user.name)
        expect(page).to have_content(@item_3.price)
        expect(page).to have_content("quantity: 2")
        expect(page).to have_content("subtotal: $#{@item_3.price * 2}")
      end
    end
  end

  context "a regular user or visitor sees an empty cart message" do
    scenario "as a regular user" do
      user = create(:user)
      login_as(user)
    end

    scenario "as a visitor" do
    end

    after :each do
      visit cart_path

      expect(page).to have_content("Your Cart is empty.")
      expect(page).to_not have_link("Empty Cart")
    end
  end
end
