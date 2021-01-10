class CreateReview < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :description
      t.integer :taste_grade
      t.integer :color_grade
      t.integer :smokiness_grade
      
      t.timestamps
    end
  end
end
