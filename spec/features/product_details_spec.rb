require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do 

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

  scenario "Click details button to navigate to product details" do
    # ACT
    visit root_path
    click_link "Details"

    # DEBUG / VERIFY
    expect(page).to have_css 'section.products-show'
    # save_screenshot
  end

  scenario "Click on image to navigate to product details" do
    # ACT
    visit root_path
    find('.product header a img').click

    # DEBUG / VERIFY
    expect(page).to have_css 'section.products-show'
    # save_screenshot
  end

end