require 'rails_helper'

RSpec.describe "clicking the logout button" do
  before :each do
    @user = create(:user)
    login_as(@user)
    visit root_path
    click_link "Log out"
  end

  it "logs out the user" do
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have successfully logged out.")
    expect(page).to have_content("Log in")
    expect(page).to_not have_content("Log Out")
  end

  it "deletes all items in the cart"
end
