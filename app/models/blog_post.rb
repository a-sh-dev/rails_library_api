class BlogPost < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :category
  validates :title, :content, presence: true
end
