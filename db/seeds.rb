# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0
  User.create(username: "bobo", email: "bobo@test.com", password: "123456", password_confirmation: "123456")
  puts "--- Created #{User.count} user/s"
end

if Category.count == 0
  categories = ["code", "health", "entertainment", "food"]
  categories.each do |category|
    Category.create(name: category)
    puts "- Created #{category} category"
  end
  puts "--- Created #{Category.count} categories"
end

if BlogPost.count == 0
  15.times do
    author = User.first
    BlogPost.create(
      author: author,
      title: Faker::Lorem.words(number: 3).join(" "),
      content: Faker::Lorem.paragraph_by_chars(number: 2000, supplemental: false),
      category_id: rand(5) + 1
    )
  end
  puts "--- Created #{BlogPost.count} blog posts"
end