class BidsController < ApplicationController
  before_action :set_bid,  only: [:show, :index]
  before_action :set_item, only: [:show, :index]

  def new
    @bid = Bid.new
  end

  def create
    @bid = Bid.new(bid_params)
    if @bid.save
      redirect_to @bid
      # flash here
    else
      render action: 'new'
  end

  def index
    @bids = Bid.where('item_id = ?', @item.id)
  end

  private

    def set_bid
      @bid = Bid.find(params[:id])
    end

    def set_item
      @item = @bid.item
    end

    def bid_params
      params.require(:item).permit(:amount, :user_id, :item_id)
    end

end
