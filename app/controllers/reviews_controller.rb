class ReviewsController < ApplicationController
  def new
    @form = ReviewForm.new
  end

  def create
    @form = ReviewForm.new(review_params)

    if @form.submit
        redirect_to new_review_path, notice: 'Thank you for creating a review'
    else
        render :new
    end
  end

  private

  def review_params
    params.require(:review_form).permit(
      :title,
      :description,
      :taste_grade,
      :color_grade,
      :smokiness_grade
    )
  end
end
