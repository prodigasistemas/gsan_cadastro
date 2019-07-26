module API
  module Filterable
    extend ActiveSupport::Concern

    module ClassMethods
      def filter_data(terms, includable = [])
        valid_associations = build_valid_associations(includable || [])

        joins_with = valid_associations[:joins]
        conditions = build_conditions(terms, valid_associations[:relations])

        self.joins(joins_with).where(conditions)
      end

      def filterable_fields
        self.attribute_aliases.keys.map(&:to_sym)
      end

      private

      def build_valid_associations(includable)
        valid_associations = { joins: [], relations: [self] }

        includable.each do |i|
          if relation = valid_relation(i.to_sym)
            valid_associations[:joins]     << i.to_sym
            valid_associations[:relations] << relation
          end
        end

        valid_associations
      end

      def valid_relation(relation)
        begin
          klass = relation.to_s.classify.constantize

          return unless self.instance_methods.include?(relation)
          return unless klass.respond_to?(:filter_data)

          klass
        rescue
          nil
        end
      end

      def build_conditions(terms, includable)
        includable.map do |relation|
          relation.send(:normalize_conditions, terms)
        end.flatten.join(" OR ")
      end

      def normalize_conditions(terms)
        return unless terms

        filterable_fields.map do |field|
          next unless attribute = attribute_alias(field)

          "cast(#{self.table_name}.#{attribute} as text) ILIKE '%#{terms}%'"
        end
      end
    end
  end
end
