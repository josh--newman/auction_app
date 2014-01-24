class Item < ActiveRecord::Base
  
  default_scope -> { order('created_at DESC') }
  belongs_to :category

  validates :name, presence: true, length: { maximum: 50 }

  def self.search(name, category_id)
    if !category_id.empty?
      where("name || description LIKE ? AND category_id = ?", 
            "%#{name}%", "#{category_id}")
    else
      where("name || description LIKE ?",
            "%#{name}%")
    end
  end

end
