module API
  module Filterable
    extend ActiveSupport::Concern

    module ClassMethods
      def filter(terms)
        query = normalize_query(terms)

        results = self.where(nil)
        results = results.where(query) if query.present?

        results
      end

      def filterable_fields
        self.attribute_aliases.keys.map(&:to_sym)
      end

      private

      def normalize_query(terms)
        return unless terms

        query = []

        filterable_fields.each do |field|
          next unless attribute = attribute_alias(field)

          query << "cast(#{self.table_name}.#{attribute} as text) ILIKE '%#{terms}%'"
        end

        query.compact.join(" OR ")
      end
    end
  end
end
