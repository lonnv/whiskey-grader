# frozen_string_literal: true

class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :average_grade, :taste_grade, :color_grade, :smokiness_grade, :brand, :url

  def brand
    object.brand.name
  end

  def url
    "/reviews/#{object.id}"
  end
end
