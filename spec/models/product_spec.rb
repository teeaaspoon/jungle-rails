require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do

    # it { is_expected.to validate_presence_of(:name) }
    # it { is_expected.to validate_presence_of(:price) }
    # it { is_expected.to validate_presence_of(:quantity) }
    # it { is_expected.to validate_presence_of(:category) }

    before :each do
      @cat1 = Category.find_or_create_by! name: 'Food'
    end

    it "initial example should be a valid product and save successfully" do
      @valid_product = Product.new({name: "McDonalds Fries", price: 5.35, quantity:10, category: @cat1})
      expect(@valid_product.valid?).to eq(true)
      expect(@valid_product.save).to eq(true)
  end

    context "validates name exists" do
    it "Should have a name" do
      @invalid_product = Product.new({name: nil, price: 5.35, quantity:10, category: @cat1})
      @valid_product = Product.new({name: "McDonalds Fries", price: 5.35, quantity:10, category: @cat1})
      expect(@invalid_product.valid?).to eq(false)
      expect(@valid_product.valid?).to eq(true)
    end

    it "Should display error message if invalid" do
      @invalid_product = Product.new({name: nil, price: 5.35, quantity:10, category: @cat1})
      @invalid_product.valid?
      expect(@invalid_product.errors.full_messages).to include("Name can't be blank")
    end
  end

  context "validates price exists" do
    it "Should have a price" do
      @invalid_product = Product.new({name: "Mcdonalds Fries", price: nil, quantity:10, category: @cat1})
      @valid_product = Product.new({name: "McDonalds Fries", price: 5.35, quantity:10, category: @cat1})
      expect(@invalid_product.valid?).to eq(false)
      expect(@valid_product.valid?).to eq(true)
    end
    it "Should display error message if invalid" do
      @invalid_product = Product.new({name: "Mcdonalds Fries", price: nil, quantity:10, category: @cat1})
      @invalid_product.valid?
      expect(@invalid_product.errors.full_messages).to include("Price can't be blank")
    end
  end

  context "validates quantity exists" do
    it "Should have a quantity" do
      @invalid_product = Product.new({name: "Mcdonalds Fries", price: 5.35, quantity:nil, category: @cat1})
      @valid_product = Product.new({name: "McDonalds Fries", price: 5.35, quantity:10, category: @cat1})
      expect(@invalid_product.valid?).to eq(false)
      expect(@valid_product.valid?).to eq(true)
    end
    it "Should display error message if invalid" do
      @invalid_product = Product.new({name: "Mcdonalds Fries", price: 5.35, quantity:nil, category: @cat1})
      @invalid_product.valid?
      expect(@invalid_product.errors.full_messages).to include("Quantity can't be blank")
    end
  end

  context "validates category exists" do
    it "Should have a quantity" do
      @invalid_product = Product.new({name: "Mcdonalds Fries", price: 5.35, quantity:10, category: nil})
      @valid_product = Product.new({name: "McDonalds Fries", price: 5.35, quantity:10, category: @cat1})
      expect(@invalid_product.valid?).to eq(false)
      expect(@valid_product.valid?).to eq(true)
    end
    it "Should display error message if invalid" do
      @invalid_product = Product.new({name: "Mcdonalds Fries", price: 5.35, quantity:10, category: nil})
      @invalid_product.valid?
      expect(@invalid_product.errors.full_messages).to include("Category can't be blank")
    end
  end


  end
end
