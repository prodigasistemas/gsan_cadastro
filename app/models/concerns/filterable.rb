module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params = {})
      query = normalize_query(filtering_params)

      results = self.where(nil)
      results = results.where(query) if query.present?

      results
    end

    def filterable_fields
      self.attribute_aliases.keys.map(&:to_sym)
    end

    private

    def normalize_query(params)
      params = params.deep_symbolize_keys
      query = []

      params.each_pair do |key, value|
        next unless attribute = attribute_alias(key)

        query << "cast(#{self.table_name}.#{attribute} as text) ILIKE '%#{value}%'" if value.present?
      end

      query.compact.join(" OR ")
    end
  end
end
