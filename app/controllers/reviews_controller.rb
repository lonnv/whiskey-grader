# frozen_string_literal: true

class ReviewsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        print(params[:filter])
        @reviews = params[:filter].present? ? Review.search_review(params[:filter]) : Review.all
        @reviews = @reviews.paginate(page: params[:page], per_page: params[:page_size])
        @entries = ActiveModel::Serializer::CollectionSerializer.new(@reviews, serializer: ReviewSerializer)
        render json: {
          entries: @entries,
          current_page: @reviews.current_page,
          per_page: @reviews.per_page,
          total_entries: @reviews.total_entries
        }
      end
    end
  end

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
