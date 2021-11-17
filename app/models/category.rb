class Category < ApplicationRecord
  has_many :books
  has_many :blog_posts
  validates :name, presence: true, length: { minimum: 3 }
end
