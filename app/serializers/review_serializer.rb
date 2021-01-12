class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :average_grade, :taste_grade, :color_grade, :smokiness_grade
end