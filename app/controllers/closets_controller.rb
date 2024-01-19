class ClosetsController < ApplicationController
  def edit
    @closet = Closet.find(params[:id])
    @closet.save
    if @closet.save
    end
  end
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
    if @closet.update(closet_params)
    redirect_to dashboard_path
    else
      render :edit
    end
  end

  def destroy
    @closet = Closet.find(params[:id])
    return if @closet.bookings.any?

    @closet.destroy
    redirect_to dashboard_path
  end

  def index
    @closets = Closet.all
    @selected_ids = params[:selected_ids]
    @markers = @closets.geocoded.map do |closet|
      {
        lat: closet.latitude,
        lng: closet.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {closet: closet}),
        marker_html: render_to_string(partial: "marker", locals: {closet: closet})
      }
    end
  end

  private

  def closet_params
    params.require(:closet).permit(:name, :location, :features, :accessibility, :state, :availability, :status, :user_id, :photo)
  end
end
