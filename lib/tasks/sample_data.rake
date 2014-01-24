namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    # Category definitions
    Category.create
  end
end