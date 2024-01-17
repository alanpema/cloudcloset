class ClosetReviewsController < ApplicationController
  def new
    @closet = Closet.find(params[:closet_id])
    @closet_review = ClosetReview.new
  end

  def create
    @closet = Closet.find(params[:closet_id])
    @closet_review = ClosetReview.new(closet_review_params)
    @closet_review.closet = @closet
    @closet_review.reviewer = current_user
    if @closet_review.save
      redirect_to closets_path
    end
  end

  def destroy
    @closet_review = ClosetReview.find(params[:id])
    @closet_review.destroy
  end

  def update
    @closet_review = ClosetReview.find(params[:id])
    @closet_review.update(closet_review_params)
    @closet_review.save!
  end

  def show
    @closet_review = ClosetReview.find(params[:id])
  end


  private

  def closet_review_params
    params.require(:closet_review).permit(:rating, :comment)
  end
end
