module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filtrar_campos(filtering_params)
      results = self.all
      filtering_params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results
    end
  end
end
