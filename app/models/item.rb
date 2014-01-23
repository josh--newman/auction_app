class Item < ActiveRecord::Base
  
  default_scope -> { order('created_at DESC') }
  belongs_to :category

  validates :name, presence: true, length: { maximum: 50 }

  def self.search(query)
    where("name LIKE ?", "%#{query}%")
  end

end
