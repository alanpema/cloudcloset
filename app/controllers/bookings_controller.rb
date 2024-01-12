class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    @user_review = UserReview.new
  end

  def new
    @closet = Closet.find(params[:closet_id])
    @booking = Booking.new
    @item = Item.new
  end

  def create
    @closet = Closet.find(params[:closet_id])
    @booking = Booking.new(booking_params)
    @booking.closet = @closet
    @booking.user = current_user
    @booking.status = "payment_pending"
    if @booking.save
      append_items
      #calculate_final_price(@booking)
      redirect_to confirmation_path(@booking)
      flash[:notice] = "Your booking has been created"
    else
      render :new
    end
  end

  def update
    @booking = Booking.find(params[:id])
    return payment_process if params["payment"] == "true"

    @booking.update(booking_params)
    @booking.save
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
  end

  private

  def payment_process
    @booking.update(status: "acceptance_pending")
    redirect_to dashboard_path
  end

  def append_items
    items_ids = JSON.parse(params.require(:booking).permit(:items)[:items])
    items_ids.each do |item_id|
      item = Item.find(item_id)
      item.update!(booking_id: @booking.id)
    end
  end

  #def calculate_final_price
    #@booking.final_price = 0
    #Item::ITEM_TYPE_PRICES
    #Item::ITEM_SIZE_PRICES
  #end

  def booking_params
    params.require(:booking).permit(:pick_up, :drop_off, :status, :final_price, :closet_id, :user_id)
  end
end
