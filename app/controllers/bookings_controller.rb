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
    @booking.save
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

  def booking_params
    params.require(:booking).permit(:pick_up, :drop_off, :status, :final_price, :closet_id, :user_id)
  end

end
