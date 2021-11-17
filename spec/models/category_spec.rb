require 'rails_helper'

RSpec.describe Category, type: :model do
  # Association test
  it { should have_many(:books) }

  # Validation tests
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(3) }
  
  context "factory" do
    before(:all) do
      @category = build(:category)
    end

    it "has a valid factory" do
      expect(@category).to be_valid
    end

    it "has the right name" do
      expect(@category.name).to eq "General category"
    end

  end
end
