class BidsController < ApplicationController
  before_action :set_bid,         only: [:show, :destroy, :create]
  before_action :set_item,        only: [:show, :destroy, :index, :create]
  before_action :auth_create_bid, only: [:create]


  def create
    @bid = Bid.new(bid_params)
    if @bid.save
      redirect_to @bid.item, notice: "Bid made!"
    else
      render @bid.item, notice: "Cannot place a bid"
    end
  end

  def destroy
    @bid.destroy
    redirect_to @item
  end

  private

    def auth_create_bid
      signed_in? && current_user.id != @item.user_id
    end

    def set_bid
      @bid = Bid.find(params[:id])
    end

    def set_item
      @item = @bid.item
    end

    def bid_params
      params.require(:bid).permit(:amount, :user_id, :item_id)
    end

end
