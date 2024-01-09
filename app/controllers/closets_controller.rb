class ClosetsController < ApplicationController

  def show
    @closet = Closet.find(params[:id])
    @booking = Booking.new
  end

  def new
    @closet = Closet.new
  end

  def create
    @closet = Closet.new(closet_params)
    @closet.user = current_user
    @closet.save
  end

  def update
    @closet = Closet.find(params[:id])
    @closet.update(closet_params)
    @closet.save
  end

  def destroy
    @closet = Closet.find(params[:id])
    @closet.destroy
  end

  private

  def closet_params
    params.require(:closet).permit(:name, :location, :features, :accessibility, :state, :availability, :status, :user_id)
  end
end
