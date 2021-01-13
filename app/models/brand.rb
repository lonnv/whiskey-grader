# frozen_string_literal: true

class Brand < ApplicationRecord
  validates_uniqueness_of :name
end
