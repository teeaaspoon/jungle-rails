require 'rails_helper'

RSpec.feature "Visitor can login", type: :feature, js: true do 

  # SETUP
  before :each do
    @user = User.create!(first_name: "Oliver", last_name: "Smith", email: "olliesmith@gmail.com", password: "123", password_confirmation: "123")
  end

  scenario "Click details button to navigate to product details" do
    # ACT
    visit root_path
    click_link "Login"
    # Fill in form with login info
    fill_in "email", with: "olliesmith@gmail.com"
    fill_in "password", with: "123"
    find("form input.btn").click

    # DEBUG / VERIFY
    # save_screenshot
    expect(page).to have_content 'Logout'
    
  end


end