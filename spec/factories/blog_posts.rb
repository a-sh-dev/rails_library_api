FactoryBot.define do
  factory :blog_post do
    title { "MyString" }
    content { "MyText" }
    user { nil }
    category { nil }
  end
end
