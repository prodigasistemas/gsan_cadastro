module API
  module Model
    def atributos(referer=nil)
      atributos([], referer)
    end

    def atributos(params=[], referer=nil)
      referencia(referer || self)
      new_params = self.as_json(only: :none, methods: params)
      hash = {}
      attribute_aliases.keys.each do |key|
        hash[key] = self.send(key.to_sym)
      end
      hash.merge(transform_params(new_params))
    end

    private

    def transform_params(params)
      new_params = {}
      params.each do |key, value|
        next if key == referencia
        if value.respond_to? :size
          new_params[key] = value.map{ |v| v.atributos(referencia) if v.respond_to? :atributos }
        else
          new_params[key] = value.atributos(referencia) if value.respond_to? :atributos
        end
      end
      new_params
    end

    def referencia(refer=nil)
      @objeto_referencia = refer.is_a?(String) ? refer : refer.class.to_s.underscore.downcase unless refer.nil?
      @objeto_referencia
    end

    module ClassMethods
      def buscar(query={})
        return [] if query.blank?
        query = query.deep_symbolize_keys
        query = query.delete_if { |key, value| value.blank? }
        entidades = where(query) unless query.blank?
        entidades || []
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end