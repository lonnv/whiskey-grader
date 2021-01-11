class ReviewForm
  include ActiveModel::Model

  attr_accessor(
    :title,
    :description,
    :taste_grade,
    :color_grade,
    :smokiness_grade
  )

  attr_reader :average_grade

  validates :title, :description, :taste_grade,
            :smokiness_grade, :color_grade, presence: true

  validates :taste_grade, :color_grade, :smokiness_grade,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5
            }

  def submit
    return false unless valid?
    make_grades_numerical
    calculate_average_grade
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

  def create_review
    Review.create(
      title: title,
      description: description,
      taste_grade: taste_grade,
      smokiness_grade: smokiness_grade,
      color_grade: color_grade,
      average_grade: average_grade
    )
  end
end
