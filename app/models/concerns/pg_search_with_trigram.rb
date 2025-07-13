module PgSearchWithTrigram
  extend ActiveSupport::Concern
  class_methods do
    def enable_pg_trigram_search(against:)
      include PgSearch::Model
      pg_search_scope :search_record_with_trigram,
        against: against,
        using: {
          tsearch: { prefix: true },
          trigram: {
            threshold: 0.1,
            word_similarity: true
          }
        },
        ignoring: :accents,
        ranked_by: ':trigram'
    end
  end
end
