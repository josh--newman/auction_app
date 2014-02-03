class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  before_save :check_bid

  default_scope -> { order("created_at DESC") }

  validates :amount,  presence: true, numericality: true
  validates :user_id, presence: true
  validates :item_id, presence: true

  def self.find_all_winning_bids
    @finished_bids = Bid.joins("JOIN items ON bids.item_id = items.id")
                        .where("items.finish_time < ?", Time.now)
    @winning_bids = []
    @finished_bids.each do |bid|
      temp = bid.order("amount DESC").first
      @winning_bids.push(temp)
    end
  end

  private

    def check_bid
      bids = Bid.where("item_id = ?", self.item_id)
      unless bids.empty?
        self.amount > bids.maximum("amount")
      end
    end

end
