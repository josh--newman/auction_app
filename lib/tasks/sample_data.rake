namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    # Category definitions
    Category.create!(name: "Books", description: "Paper things with words")
    Category.create!(name: "Movies", description: "Moving pictures")
    Category.create!(name: "Electronics", description: "Plug them into a power point")
    Category.create!(name: "Clothing", description: "Fabric items that you wear")
    Category.create!(name: "Boats", description: "Floating objects that move across water")
    Category.create!(name: "Cars", description: "Metal and tires with an engine")

    User.create!(name: "Admin Administrator", 
                 email: "admin@email.com", 
                 password: "password", 
                 password_confirmation: "password", admin: 1)

    User.create!(name: "Josh Newman", 
                 email: "josh.newman4390@gmail.com", 
                 password: "password", 
                 password_confirmation: "password", admin: 1)

    User.create!(name: "Matthew Shipman", 
                 email: "mshipman@hotmail.com.au", 
                 password: "password",
                 password_confirmation: "password")

    User.create!(name: "Rob Chatfield", 
                 email: "rjchatfield@gmail.com", 
                 password: "password", 
                 password_confirmation: "password")

    

    # Item definitions
    20.times do |n|
      name           = Faker::Commerce.product_name
      user_id        = rand(1..4)
      category_id    = rand(1..6)
      description    = Faker::Lorem.paragraph
      starting_price = rand(10..999) - 0.05
      finish_time    = [2, 10].sample.days.from_now
      Item.create!(name:           name,
                   user_id:        user_id,
                   category_id:    category_id,
                   description:    description,
                   starting_price: starting_price,
                   finish_time:    finish_time)
    end

    Item.create!(name:           "Harry Potter",
                 user_id:        1,
                 category_id:    1,
                 description:    "Complete book set",
                 starting_price: 60,
                 finish_time:    Time.now + 1.minute)

    Bid.create!(amount:  70,
                user_id: 2,
                item_id: 21)
    
  end
end