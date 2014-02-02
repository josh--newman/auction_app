class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  before_save :check_bid

  default_scope -> { order("created_at DESC") }

  validates :amount,  presence: true, numericality: true
  validates :user_id, presence: true
  validates :item_id, presence: true

  private

    def check_bid
      bids = Bid.where("item_id = ?", self.item_id)
      unless bids.empty?
        self.amount > bids.maximum("amount")
      end
    end

end
