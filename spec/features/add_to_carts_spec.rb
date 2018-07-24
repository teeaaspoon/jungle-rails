require 'rails_helper'

RSpec.feature "Add to cart button increases cart by one", type: :feature, js: true do 

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
  end

  scenario "Click on add to cart button and check cart count" do
    # ACT
    visit root_path
    click_link "Add"

    # DEBUG / VERIFY
    expect(page).to have_content 'Cart (1)'
    save_screenshot
  end


end