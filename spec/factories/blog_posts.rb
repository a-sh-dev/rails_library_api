FactoryBot.define do
  factory :blog_post do
    association :author, factory: :user
    association :category
    title { "Simple blog post title" }
    content { "Trying to learn TDD!" }
  end
end
