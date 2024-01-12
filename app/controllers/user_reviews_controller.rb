class UserReviewsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @user_review = UserReview.new
  end

  def create
    @user_review = UserReview.new(user_review_params)
    @user_review.reviewer = current_user
    @user_review.reviewee = # El que creo el booking  @user = User.find(params[:user_id])
    @user_review.save!
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
