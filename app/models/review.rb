# frozen_string_literal: true

class Review < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_review, against: { title: 'A', description: 'B' },
                                  using: {
                                    tsearch: { dictionary: 'english' },
                                    trigram: {
                                      threshold: 0.1,
                                      only: [:title]
                                    }
                                  }
end
