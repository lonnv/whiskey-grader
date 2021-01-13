# frozen_string_literal: true

class CreateBrand < ActiveRecord::Migration[6.1]
  def change
    create_table :brands do |t|
      t.string :name
      t.timestamps
    end

    add_reference :reviews, :brand, index: true, foreign_key: true
  end
end
