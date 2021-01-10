class Review
  include ActiveModel::Model
  attr_accessor :title, :description, :taste, :smokiness, :color
   def save
      true
   end
end