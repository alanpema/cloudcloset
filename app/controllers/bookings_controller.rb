class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @closet = Closet.find(params[:closet_id])
    @booking = Booking.new
  end

  def create
    @closet = Closet.find(params[:closet_id])
    @booking = Booking.new(booking_params)
    @booking.closet = @closet
    @booking.user = current_user
    @booking.status = "payment_pending"
    append_items
    if @booking.save
      redirect_to dashboard_path
      flash[:notice] = "Your booking has been created"
    else
      render :new
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    @booking.save
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
  end

  private

  def append_items
    items_ids = JSON.parse(params.require(:booking).permit(:items)[:items])
    items_ids.each do |item_id|
      item = Item.find(item_id)
      item.update!(booking_id: @booking.id)
    end
  end

  def booking_params
    params.require(:booking).permit(:pick_up, :drop_off, :status, :final_price, :closet_id, :user_id)
  end
end
