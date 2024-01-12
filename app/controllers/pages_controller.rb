class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
  end

  def dashboard
    @user = current_user
    @items = Item.where(user_id: current_user.id)
    @bookings = Booking.where(user_id: current_user.id)
    @bookings_as_owner = Booking.joins(:instrument).where(items: { user_id: current_user.id })
    @item = Item.new
    @closet = Closet.new
  end

  def confirmation
    @booking = Booking.find(params[:id])
    return if @booking.user != current_user

  end
end
