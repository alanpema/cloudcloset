class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def create
    number_of_items = params[:item][:multiple].to_i
    number_of_items += 1 if number_of_items.zero?
    number_of_items.times do
      @item = Item.new(item_params)
      @item.user = current_user
      @item.save!
    end
    handle_redirect
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
    @item.update!(item_params)
    respond_to do |format|
      format.html { redirect_to items_path }
      format.text { render partial: "items/item_infos", locals: {item: @item}, formats: [:html] }
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to dashboard_path
  end

  def get_item
    @item = Item.find_by(id: params[:id])
    respond_to do |format|
      if @item
        format.text { render partial: "items/item_infos", locals: {item: @item}, formats: [:html] }
      else
        format.json { render json: { error: "Item not found" }, status: :not_found }
      end
    end
  end

  def checkbox_items
    @selected_items = []
  end

  private

  def handle_redirect
    if params[:redirect] == "true"
      redirect_to dashboard_path
    else
      redirect_to new_closet_booking_path(Closet.find(params["item"]["closet"]), item: @item)
    end
  end

  def item_params
    params.require(:item).permit(:name, :item_type, :fragility, :state, :size, :sell_price, :status, :photo)
  end
end
