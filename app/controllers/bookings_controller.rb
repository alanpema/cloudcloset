class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    @user_review = UserReview.new
    @closet = @booking.closet
    @closet_review = ClosetReview.new
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
    if @booking.save
      @booking.update(status: 0)
      append_items
      calculate_final_price
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

  def accepted
    @booking = Booking.find(params[:id])
    @booking.update(status: 2)
    redirect_to dashboard_path
  end

  def declined
    @booking = Booking.find(params[:id])
    @booking.update(status: 3)
    redirect_to dashboard_path
  end

  private

  def payment_process
    @booking.update(status: 1)
    redirect_to dashboard_path
  end

  def append_items
    items_ids = JSON.parse(params.require(:booking).permit(:items)[:items])
    items_ids.each do |item_id|
      item = Item.find(item_id)
      item.update!(booking_id: @booking.id)
    end
  end

  def calculate_final_price
    final_price = 0
    @booking.items.each do |item|
      final_price += (Item::TYPE_PRICES[item.item_type])* (Item::SIZE_PRICES[item.size])
    end
    number_of_days = (@booking.drop_off - @booking.pick_up).to_i
    final_price *= number_of_days
    @booking.update(final_price: final_price)
  end

  def booking_params
    params.require(:booking).permit(:pick_up, :drop_off, :status, :final_price, :closet_id, :user_id)
  end
end
