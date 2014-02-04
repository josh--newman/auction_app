class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  before_save :check_bid

  default_scope -> { order("bids.created_at DESC") }

  validates :amount,  presence: true, numericality: true
  validates :user_id, presence: true
  validates :item_id, presence: true

  def self.find_highest_bidder(item)
    highest_bid = Bid.where("item_id = ?", item.id)
                     .order("amount DESC").first
    highest_bidder = highest_bid.user_id
  end

  private

    def check_bid
      bids = Bid.where("item_id = ?", self.item_id)
      unless bids.empty?
        self.amount > bids.maximum("amount")
      end
    end

end
