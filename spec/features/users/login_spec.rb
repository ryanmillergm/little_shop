require 'rails_helper'

RSpec.describe "the login page" do
  before :each do
    @user = create(:user)
    @merchant = create(:merchant)
    @admin = create(:admin)

    visit login_path
  end

  it "can login a regular user" do
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Log In"

    expect(current_path).to eq(profile_path)

    expect(page).to have_content("You are now logged in!")
  end

  it "can login a merchant" do
    fill_in :email, with: @merchant.email
    fill_in :password, with: @merchant.password

    click_button "Log In"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("You are now logged in!")
  end

  it "can login an admin" do
    fill_in :email, with: @admin.email
    fill_in :password, with: @admin.password

    click_button "Log In"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are now logged in!")
  end

  describe "when credentials are bad" do
    it "fails to login when password does not match email" do
      fill_in :email, with: @user.email
      fill_in :password, with: "incorrect password"

      click_button "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry, that email and password don't match.")
    end

    it "fails to login when email doesn't exist" do
      fill_in :email, with: "unknown@example.com"
      fill_in :password, with: "password"

      click_button "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Sorry, that email and password don't match.")
    end
  end
end
