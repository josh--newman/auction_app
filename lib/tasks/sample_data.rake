namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    # Category definitions
    Category.create!(name: "Books", description: "Paper things with words")
    Category.create!(name: "Movies", description: "Moving pictures")
    Category.create!(name: "Electronics", description: "Plug them into a power point")
    Category.create!(name: "Clothing", description: "Fabric items that you wear")
    Category.create!(name: "Sunglasses", description: "Wear them to protect your eyes")
    Category.create!(name: "Body Parts", description: "Internal organs and external extremities")
    Category.create!(name: "Boats", description: "Floating objects that move across water")
    Category.create!(name: "Chairs", description: "Wooden or otherwise, have four legs")
    Category.create!(name: "Wigs", description: "Are you bald? Get one of these")
    Category.create!(name: "Cars", description: "Metal and tires with an engine")

    # Item definitions
    99.times do |n|
      name = Faker::Commerce.product_name
      vendor = Faker::Name.name
      category_id = rand(1..10)
      description = Faker::Lorem.paragraph
      starting_price = rand(10..999) - 0.05
      Item.create!(name:           name,
                   vendor:         vendor,
                   category_id:    category_id,
                   description:    description,
                   starting_price: starting_price)
    end

    User.create!(name: "Matthew Shipman", 
                 email: "mshipman@hotmail.com.au", 
                 password: "password",
                 password_confirmation: "password")

    User.create!(name: "Rob Chatfield", 
                 email: "rjchatfield@gmail.com", 
                 password: "password", 
                 password_confirmation: "password")

    User.create!(name: "Jiji", 
                 email: "jiji@cat.com", 
                 password: "password",
                 password_confirmation: "password")

    User.create!(name: "Test Tester", 
                 email: "test@test.com", 
                 password: "password", 
                 password_confirmation: "password")

    User.create!(name: "Josh Newman", 
                 email: "josh.newman4390@gmail.com", 
                 password: "password", 
                 password_confirmation: "password", admin: 1)
    
  end
end