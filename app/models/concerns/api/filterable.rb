module API
  module Filterable
    extend ActiveSupport::Concern

    module ClassMethods
      def filter(terms, includable = [])
        joins_with = []
        conditions = []
        relations  = [self]

        results = self.where(nil)

        # valid joins
        includable = includable || []
        includable.map do |r|
          if relation = valid_relation(r.to_sym)
            joins_with << r.to_sym
            relations << relation
          end
        end

        results = results.joins(joins_with)

        # query
        query = relations.map do |relation|
          relation.normalize_conditions(terms)
        end.flatten.join(" OR ")

        results.where(query)
      end

      def filterable_fields
        self.attribute_aliases.keys.map(&:to_sym)
      end

      def normalize_conditions(terms)
        return unless terms

        filterable_fields.map do |field|
          next unless attribute = attribute_alias(field)

          "cast(#{self.table_name}.#{attribute} as text) ILIKE '%#{terms}%'"
        end
      end

      def valid_relation(relation)
        begin
          klass = relation.to_s.classify.constantize

          return unless self.instance_methods.include?(relation)
          return unless klass.respond_to?(:filter)

          klass
        rescue
          nil
        end
      end
    end
  end
end
