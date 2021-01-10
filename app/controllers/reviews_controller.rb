class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
        redirect_to new_review_path, notice: 'Thank you for creating a review'
    else
        render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(
        :title,
        :description,
        :taste,
        :color,
        :smokiness
    )
  end
end
