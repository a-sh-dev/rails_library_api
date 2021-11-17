require 'rails_helper'

RSpec.describe User, type: :model do
  context "factory" do
    before(:all) do
      @user = build(:user)
    end

    it "has a valid factory" do
      expect(@user).to be_valid
    end

    it "has the right name" do
      expect(@user.username).to eq "user1"  
    end
  end

  context "validations" do
    before(:each) do
      @user = build(:user)
    end

    it "is invalid without a username" do
      @user.username = nil
      expect(@user).to_not be_valid
    end

    it "is invalid without an email" do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it "is invalid without a password" do
      user = build(:user, password_confirmation: nil)
      expect(user).to_not be_valid  
    end

    it "is invalid when password and confirmation don't match" do
      user = build(:user, password_confirmation: "password-")
      expect(user).to_not be_valid  
    end

  end
  
  
end
