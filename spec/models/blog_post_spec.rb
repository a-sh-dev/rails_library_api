require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  # Sample test without 'shoulda-matchers'
  # it "should belong to an author" do
  #   t = BlogPost.reflect_on_association(:author)
  #   expect(t.macro).to eq(:belongs_to)
  # end

  # Association tests
  context "associations" do
    it { should belong_to(:author).class_name("User") }
    it { should belong_to(:category) }
  end

  # Validation tests
  context "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end
