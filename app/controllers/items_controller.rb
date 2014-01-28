class ItemsController < ApplicationController
  before_action :set_item,       only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:edit, :new, :create, :index]

  def index
    if (params[:search] && params[:category])
      # this will search the DB for the specified params
      # and return them ordered by last created first
      @items = Item.search(params[:search], params[:category]).order("created_at DESC")
    else
      @items = Item.all
    end
    # then paginate the items
    @items = @items.paginate(page: params[:page], per_page: 10)
  end

  def edit

  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save   #success
      redirect_to root_url
    else            # failure
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    # this method collects the category names and id's
    # for the dropdown menu in the form
    def set_categories
      @categories = Category.all.collect { |c| [c.name, c.id] }
    end

    def item_params
      params.require(:item).permit(:name, :description, 
                                   :vendor, :starting_price, :category_id)
    end

end
