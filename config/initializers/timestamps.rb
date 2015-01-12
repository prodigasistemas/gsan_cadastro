# http://stackoverflow.com/questions/6635268/rails3-timestamp-mapping-to-legacy-table

module ActiveRecord
  module Timestamp
    private
    def timestamp_attributes_for_update #:nodoc:
      [:atualizado_em, :updated_at, :updated_on]
    end
    #def timestamp_attributes_for_create #:nodoc:
    #  [:CRIADO_EM, :created_at, :created_on]
    #end
  end
end
