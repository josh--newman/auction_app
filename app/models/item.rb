class Item < ActiveRecord::Base
  
  default_scope -> { order('created_at DESC') }
  belongs_to :category

  validates :name, presence: true, length: { maximum: 50 }
  validates :category_id, presence: true
  validates :vendor, presence: true

  def self.search(name, category_id)
    if !category_id.empty?
      # search with category_id
      where("name || description LIKE ? AND category_id = ?", 
            "%#{name}%", "#{category_id}")
    else
      # there is no category_id
      where("name || description LIKE ?",
            "%#{name}%")
    end
  end

end
