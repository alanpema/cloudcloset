class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @item.save!
    redirect_to dashboard_path
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @booking = Booking.new
  end

  def edit
    @item = Item.find(params[:id])
    @item.save
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    @item.save
    redirect_to dashboard_path
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to dashboard_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :item_type, :fragility, :state, :size, :sell_price, :status, :photo)
  end
end
