# frozen_string_literal: true

class ReviewForm
  include ActiveModel::Model

  attr_accessor(
    :title,
    :description,
    :taste_grade,
    :color_grade,
    :smokiness_grade,
    :brand
  )

  attr_reader :average_grade

  validates :title, :description, :taste_grade,
            :smokiness_grade, :color_grade, :brand, presence: true

  validates :taste_grade, :color_grade, :smokiness_grade,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5
            }

  def brand_options
    Brand.all.pluck(:name).map { |name| { value: name, label: name } }
  end

  def submit
    return false unless valid?

    make_grades_numerical
    calculate_average_grade
    set_brand
    create_review
  end

  private

  def make_grades_numerical
    @smokiness_grade = smokiness_grade.to_i
    @color_grade = color_grade.to_i
    @smokiness_grade = smokiness_grade.to_i
  end

  def calculate_average_grade
    @average_grade = ((color_grade + color_grade + smokiness_grade) / 3).round(1)
  end

  def set_brand
    @brand = Brand.find_or_create_by(name: brand)
  rescue ActiveRecord::RecordNotUnique
    retry
  end

  def create_review
    Review.create(
      title: title,
      brand: brand,
      description: description,
      taste_grade: taste_grade,
      smokiness_grade: smokiness_grade,
      color_grade: color_grade,
      average_grade: average_grade
    )
  end
end
