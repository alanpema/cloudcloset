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
    if @closet.save
      redirect_to dashboard_path
    else
      render :new
    end
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

def index
  @closets = Closet.all
  @markers = @closets.geocoded.map do |closet|
    {
      lat: closet.latitude,
      lng: closet.longitude
    }
  end
end

  private

  def closet_params
    params.require(:closet).permit(:name, :location, :features, :accessibility, :state, :availability, :status, :user_id, :photo)
  end
end
