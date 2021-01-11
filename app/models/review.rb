class Review
  include ActiveModel::Model
  attr_accessor :title, :description, :taste_grade, :smokiness_grade, :color_grade
   def save
      true
   end
end