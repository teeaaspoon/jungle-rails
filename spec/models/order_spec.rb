require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do 
    

    before :each do
      @cat1 = Category.find_or_create_by! name: 'Food'
      @product1 = Product.create!(name: "Cheese Burger", price: 6.00, quantity: 30, category: @cat1)
      @product2 = Product.create!(name: "Pho", price: 9.00, quantity: 10, category: @cat1)
      @product3 = Product.create!(name: "Spaghetti", price: 14.50, quantity: 50, category: @cat1)
    end
  

  it 'deducts quantity from products based on their line item quantities' do
    @order = Order.new(
      email: "james.dymond@gmail.com",
      total_cents: 600,
      stripe_charge_id: "ch_1CrCEII7Y10E4UfL47nENFYS", # returned by stripe
    )
    @order.line_items.new(
      product: @product1,
      quantity: 2,
      item_price: @product1.price,
      total_price: @product1.price * 2
    )
    @product1.quantity = @product1.quantity - 2
    @order.save!
    @product1.save
    @product1.reload
    @product2.reload
    expect(@product1.quantity).to eq(28)
  end

  it 'does not deduct quantity from products that are not in the order' do
    @order = Order.new(
      email: "james.dymond@gmail.com",
      total_cents: 600,
      stripe_charge_id: "ch_1CrCEII7Y10E4UfL47nENFYS", # returned by stripe
    )
    @order.line_items.new(
      product: @product1,
      quantity: 2,
      item_price: @product1.price,
      total_price: @product1.price * 2
    )
    @product1.quantity = @product1.quantity - 2
    @order.save!
    @product1.save!
    @product1.reload
    @product2.reload
    expect(@product1.quantity).to eq(28)
    expect(@product2.quantity).to eq(10)
  end

  end
end
