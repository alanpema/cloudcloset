class UserReviewsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @user_review = UserReview.new
  end

  def create
    @user_review = UserReview.new(user_review_params)
    @user_review.reviewer = current_user
    @booking = Booking.find(params[:user_review][:booking_id])
    @user_review.reviewee = @booking.user
    @user_review.save!
    redirect_to dashboard_path
  end

  def destroy
    @user_review = UserReview.find(params[:id])
    @user_review.destroy
  end

  def update
    @user_review = UserReview.find(params[:id])
    @user_review.update(user_review_params)
    @user_review.save!
  end

  def show
    @user_review = UserReview.find(params[:id])
  end

  private

  def user_review_params
    params.require(:user_review).permit(:rating, :content)
  end
end
