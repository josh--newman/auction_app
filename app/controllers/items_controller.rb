class ItemsController < ApplicationController
  before_action :set_item,                      only: [:show, :edit, :update, :destroy]
  before_action :set_categories,                only: [:edit, :new, :create, :index]
  before_action :set_days,                      only: [:new, :create, :edit, :update]

  before_action :auth_new_item,                 only: [:new, :create]
  before_action :auth_edit_update_destroy_item, only: [:edit, :update, :destroy]
  before_action :auth_edit_update_no_bids,      only: [:edit, :update]

  def index
    if (params[:search] && params[:category])
      # this will search the DB for the specified params
      # and return them ordered by last created first
      @items = Item.search(params[:search], params[:category]).order("created_at DESC")
    else
      @items = Item.all
    end
    # then paginate the items
    @items = @items.paginate(page: params[:page], per_page: 5)
  end

  def show
    @bid = Bid.new
    @bids = Bid.where("item_id = ?", @item.id)
    @bids = @bids.paginate(page: params[:page], per_page: 5)
  end

  def edit

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save   #success
      redirect_to @item, notice: "Item created successfully"
    else            # failure
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "Item updated successully"
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: "Item deleted"
  end

  private

    def auth_new_item
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in"
      end
    end

    def auth_edit_update_destroy_item
      unless signed_in? && (@item.user_id == current_user.id || current_user.admin)
        store_location
        redirect_to signin_path, notice: "Please sign in"
      end
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def auth_edit_update_no_bids
      if @item.bids.count > 0
        redirect_to @item, notice: "This item has been bid on and cannot be edited"
      end
    end

    # this method collects the category names and id's
    # for the dropdown menu in the form
    def set_categories
      @categories = Category.all.collect { |c| [c.name, c.id] }
    end

    # sets the days with datetimes for the new item form
    def set_days
      @days = []
      (1..30).each do |i|
        @days.push([(ActionController::Base.helpers.pluralize(i, 'day')),
                    (Time.now + i.days)])
      end
      @days
    end

    def item_params
      params.require(:item).permit(:name, :description, :user_id,
                                   :starting_price, :category_id, 
                                   :finish_time, :image_preview)
    end

end
