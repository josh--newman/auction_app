class Item < ActiveRecord::Base
  
  default_scope -> { order('created_at DESC') }
  belongs_to :category
  belongs_to :user
  has_many :bids, dependent: :destroy

  has_attached_file :image_preview, 
                    :styles => { :medium => "256x256#", :thumb => "180x180#" },
                    :default_url => "missing.png"
  validates_attachment_content_type :image_preview, 
  :content_type => ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  validates :name, presence: true, length: { maximum: 50 }
  validates :category_id, presence: true
  validates :user_id,     presence: true
  validates :finish_time, presence: true

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

  def self.find_won_items(user)
    @user_id = user.id
 
    # Gets all the bids that user has bid on
    @bids = Bid.where("user_id = ?", @user_id)
 
    # Gets all the item id's that the user has bid on
    @items_id = []
    @bids.each do |bid|
      if bid.user_id = @user_id
        @items_id.push(bid.item_id)
      end
    end
 
    # Gets all the items that a user has bid on and that are closed
    # This should also remove duplicates
    @closed_items = []
    @items = Item.where("finish_time < ?", Time.now)
    @items.each do |item|
      if @items_id.include?(item.id)
        @closed_items.push(item)
      end
    end
    # Remove duplicates
    @closed_items.uniq
 
    # Get all the winning items the user has won
    @won_items = []
    @closed_items.each do |item|
      if @user_id == Bid.find_highest_bidder(item)
        @won_items.push(item)
      end
    end
 
    @won_items
   
  end

end
