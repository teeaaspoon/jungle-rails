require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    before :each do
      @valid_user = User.new(first_name: "Oliver", last_name: "Smith", email: "olliesmith@gmail.com", password: "123", password_confirmation: "123")
      @invalid_user = User.new(first_name: "Oliver", last_name: "Smith", email: "olliesmith@gmail.com", password: nil, password_confirmation: nil)
    end

    it "Must Be Created with Password and Password Confirmation fields" do
      expect(@invalid_user.valid?).to eq(false)
    end

    it "Password and Password Confirmation fields must match" do
      @invalid_user.password = "123"
      @invalid_user.password_confirmation = "456"
      expect(@invalid_user.password).not_to eq(@invalid_user.password_confirmation)
      expect(@invalid_user.valid?).to eq(false)
    end

    it "Should check if emails are unique and case sensitve" do
      @valid_user.save
      @invalid_user1 = User.new(first_name: "Oliver", last_name: "Smith", email: "olliesmith@gmail.com", password: "123", password_confirmation: "123")
      @invalid_user2 = User.new(first_name: "Oliver", last_name: "Smith", email: "OLLIESMITH@GMAIL.COM", password: "123", password_confirmation: "123")
      expect(@invalid_user1.valid?).to eq(false)
      expect(@invalid_user2.valid?).to eq(false)
    end

    it "Should check if email, first_name and last_name are present" do
      @invalid_user1 = User.new(first_name: nil, last_name: "Sherry", email: "marksherry@gmail.com", password: "123", password_confirmation: "123")
      @invalid_user2 = User.new(first_name: "Mark", last_name: nil, email: "marksherry@gmail.com", password: "123", password_confirmation: "123")
      @invalid_user3 = User.new(first_name: "Mark", last_name: "Sherry", email: nil, password: "123", password_confirmation: "123")
      expect(@invalid_user1.valid?).to eq(false)
      expect(@invalid_user2.valid?).to eq(false)
      expect(@invalid_user3.valid?).to eq(false)
    end

    it "Should check that the password is a minimum of 3 characters" do
      @invalid_user.password = "1"
      @invalid_user.password_confirmation = "1"
      expect(@valid_user.valid?).to eq(true)
      expect(@invalid_user.valid?).to eq(false)
    end

  end

  describe '.authenticate_with_credentials' do
    before :each do
      @valid_user = User.new(first_name: "Oliver", last_name: "Smith", email: "olliesmith@gmail.com", password: "123", password_confirmation: "123")
      @valid_user.save
    end
    it "Should return an instance of the user if sucessfully authenticated" do
      expect(User.authenticate_with_credentials("olliesmith@gmail.com", "123")).to eq(@valid_user)
    end
    it "Should allow the user to be authenticated if they have spaces before or after their email" do
      expect(User.authenticate_with_credentials("     olliesmith@gmail.com", "123")).to eq(@valid_user)
      expect(User.authenticate_with_credentials("olliesmith@gmail.com     ", "123")).to eq(@valid_user)
    end

    it "Should allow the user to login with different cased email" do
      expect(User.authenticate_with_credentials("OlLieSmith@gmail.COM", "123")).to eq(@valid_user)
      expect(User.authenticate_with_credentials("     OlLieSmith@GMAIL.COM", "123")).to eq(@valid_user)
    end


  end

end
