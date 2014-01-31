module BidsHelper

  def min_bid_value_for(item)
    (find_highest_bid_for(item)) + 0.01
  end

  def find_highest_bid_for(item)
    bids = Bid.where("item_id = ?", item.id)
    if bids.count > 0
      bids.maximum("amount")
    else
      item.starting_price
    end
  end

end
