# frozen_string_literal: true

class Review < ApplicationRecord
  include PgSearch::Model
  belongs_to :brand
  pg_search_scope :search_review, against: { title: "A", description: "B" },
                                  associated_against: {
                                    brand: [:name],
                                  },
                                  using: {
                                    tsearch: { dictionary: "english" },
                                    trigram: {
                                      threshold: 0.2,
                                      only: [:title],
                                    },
                                  }
end
